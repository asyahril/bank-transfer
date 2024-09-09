--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

-- Started on 2024-09-09 07:35:38 WIB

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 30332)
-- Name: bank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank (
    bank character varying(20) NOT NULL,
    biaya_admin integer NOT NULL
);


ALTER TABLE public.bank OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 30322)
-- Name: counter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.counter (
    prefix character varying(20) NOT NULL,
    value integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.counter OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 30284)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 30283)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 214
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 210 (class 1259 OID 30259)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 30258)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 209
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 213 (class 1259 OID 30276)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 30296)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 30295)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 216
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 220 (class 1259 OID 30337)
-- Name: rekening_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rekening_admin (
    bank character varying(20) NOT NULL,
    rekening character varying(30) NOT NULL,
    atasnama character varying(30) NOT NULL
);


ALTER TABLE public.rekening_admin OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 30342)
-- Name: transaksi_transfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaksi_transfer (
    id_transaksi character varying(20) NOT NULL,
    nilai_transfer integer NOT NULL,
    bank_tujuan character varying(20) NOT NULL,
    rekening_tujuan character varying(30) NOT NULL,
    atasnama_tujuan character varying(30) NOT NULL,
    bank_pengirim character varying(20) NOT NULL,
    kode_unik integer NOT NULL,
    biaya_admin integer NOT NULL,
    total_transfer integer NOT NULL,
    bank_perantara character varying(20) NOT NULL,
    rekening_perantara character varying(30) NOT NULL,
    berlaku_hingga timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.transaksi_transfer OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 30266)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 30265)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3244 (class 2604 OID 30287)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 30262)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 30299)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 30269)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3421 (class 0 OID 30332)
-- Dependencies: 219
-- Data for Name: bank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank (bank, biaya_admin) FROM stdin;
BNI	0
BCA	0
\.


--
-- TOC entry 3420 (class 0 OID 30322)
-- Dependencies: 218
-- Data for Name: counter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.counter (prefix, value, created_at, updated_at) FROM stdin;
TF240909	6	\N	2024-09-09 00:30:43
\.


--
-- TOC entry 3417 (class 0 OID 30284)
-- Dependencies: 215
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 3412 (class 0 OID 30259)
-- Dependencies: 210
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_reset_tokens_table	1
3	2019_08_19_000000_create_failed_jobs_table	1
4	2019_12_14_000001_create_personal_access_tokens_table	1
8	2024_09_08_070210_create_counter_table	1
10	2024_09_07_232310_create_bank_table	2
11	2024_09_07_232335_create_rekening_admin_table	3
12	2024_09_07_232350_create_transaksi_transfer_table	4
\.


--
-- TOC entry 3415 (class 0 OID 30276)
-- Dependencies: 213
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 3419 (class 0 OID 30296)
-- Dependencies: 217
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3422 (class 0 OID 30337)
-- Dependencies: 220
-- Data for Name: rekening_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rekening_admin (bank, rekening, atasnama) FROM stdin;
BNI	12700283733	PT BosCOD Indonesia
BCA	12700283735	PT BosCOD Indonesia
\.


--
-- TOC entry 3423 (class 0 OID 30342)
-- Dependencies: 221
-- Data for Name: transaksi_transfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaksi_transfer (id_transaksi, nilai_transfer, bank_tujuan, rekening_tujuan, atasnama_tujuan, bank_pengirim, kode_unik, biaya_admin, total_transfer, bank_perantara, rekening_perantara, berlaku_hingga) FROM stdin;
TF24090900005	50000	BCA	60184819385	Fulanah	BNI	183	0	50183	BNI	12700283733	2024-09-12 00:29:35
TF24090900006	50000	BCA	60184819383	Fulan	BNI	487	0	50487	BNI	12700283733	2024-09-12 00:30:43
\.


--
-- TOC entry 3414 (class 0 OID 30266)
-- Dependencies: 212
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
2	User	user@boscod.com	\N	$2y$12$XeaiTy66eKX9Zwm71o.B8.e5d0Y3SwFjh1k9NpcreAuL8a9FjZm..	wIgKjXJhpcKjv0gSaIOkpV3MqyKW7xF5VQ0cK1DaN6mNzt6lo0hHvLUyvIRo	2024-09-08 14:17:28	2024-09-08 23:28:10
1	asyahril	asyahril416@gmail.com	\N	$2y$12$CFeaO13WgmIakq6I77kPf.6Yt0UL8B/ybX9E3rIyOb6QuaRhaRzO6	kJwLusIIrHiXoM1Cq6ZhQYs0OgZFuNFVt5GQ4CA0QI0yshw8SLVKpwEFUrBS	2024-09-08 13:43:28	2024-09-08 23:38:33
\.


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 214
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 209
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 12, true);


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 216
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 3267 (class 2606 OID 30336)
-- Name: bank bank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank
    ADD CONSTRAINT bank_pkey PRIMARY KEY (bank);


--
-- TOC entry 3265 (class 2606 OID 30326)
-- Name: counter counter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.counter
    ADD CONSTRAINT counter_pkey PRIMARY KEY (prefix);


--
-- TOC entry 3256 (class 2606 OID 30292)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 30294)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3248 (class 2606 OID 30264)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 30282)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 3260 (class 2606 OID 30303)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3262 (class 2606 OID 30306)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3269 (class 2606 OID 30341)
-- Name: rekening_admin rekening_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rekening_admin
    ADD CONSTRAINT rekening_admin_pkey PRIMARY KEY (bank);


--
-- TOC entry 3271 (class 2606 OID 30346)
-- Name: transaksi_transfer transaksi_transfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi_transfer
    ADD CONSTRAINT transaksi_transfer_pkey PRIMARY KEY (id_transaksi);


--
-- TOC entry 3250 (class 2606 OID 30275)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 3252 (class 2606 OID 30273)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3263 (class 1259 OID 30304)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


-- Completed on 2024-09-09 07:35:39 WIB

--
-- PostgreSQL database dump complete
--

