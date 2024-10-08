<?php

namespace App\Http\Controllers;

use Hash;
use Illuminate\Http\Request;
use App\Models\User;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;
use Str;
use Validator;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'updateToken', 'register']]);
    }

    public function register(Request $request) 
    {
        $ok = true;
        $input = $request->all();
        $message = '';

        $validator = Validator::make($input, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            $errorList = $validator->errors()->toArray();
            $message = '';

            foreach ($errorList as $field => $value) {
                $message .= sprintf("%s: %s", $field, $value[0]);
            }

            $ok = false;
        }

        if ($ok) {
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);

            if (!$user) {
                $ok = false;
                $message = 'Failed to create user!';
            } else {
                $message = 'User created successfully';
            }
        }

        return response()->json([
            'success' => $ok,
            'message' => $message,
        ]);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
        $credentials = request(['email', 'password']);

        if (!isset($credentials['email'])) {
            $credentials['email'] = request('username');
        }

        $token = auth()->attempt($credentials);

        if (!$token) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token, auth()->user());
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateToken()
    {
        $refreshToken = request('token');
        $user = User::where('remember_token', $refreshToken)->first();

        if (isset($user)) {
            $token = JWTAuth::fromUser($user);

            return $this->respondWithToken($token, $user);
        } else {
            return response()->json(['error' => 'Invalid refresh token'], 400);
        }
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token, $user)
    {
        return response()->json([
            'accessToken' => $token,
            'refreshToken' => $this->getRefreshToken($user)
        ]);
    }

    protected function getRefreshToken($user)
    {
        if (!isset($user->remember_token)) {
            $refreshToken = Str::random(60);

            $user->remember_token = $refreshToken;
            $user->save();
    
            return $refreshToken;
        } else {
            return $user->remember_token;
        }
    }

}
