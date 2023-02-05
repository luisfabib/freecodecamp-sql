--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (31, 'user_1675606988253', 5, 227);
INSERT INTO public.users VALUES (14, 'user_1675606884370', 2, 476);
INSERT INTO public.users VALUES (13, 'user_1675606884371', 5, 301);
INSERT INTO public.users VALUES (16, 'user_1675606920195', 2, 119);
INSERT INTO public.users VALUES (15, 'user_1675606920196', 5, 220);
INSERT INTO public.users VALUES (18, 'user_1675606952465', 2, 240);
INSERT INTO public.users VALUES (17, 'user_1675606952466', 5, 35);
INSERT INTO public.users VALUES (20, 'user_1675606958909', 2, 675);
INSERT INTO public.users VALUES (19, 'user_1675606958910', 5, 439);
INSERT INTO public.users VALUES (22, 'user_1675606963936', 2, 422);
INSERT INTO public.users VALUES (21, 'user_1675606963937', 5, 415);
INSERT INTO public.users VALUES (24, 'user_1675606970374', 2, 287);
INSERT INTO public.users VALUES (23, 'user_1675606970375', 5, 428);
INSERT INTO public.users VALUES (26, 'user_1675606973315', 2, 119);
INSERT INTO public.users VALUES (25, 'user_1675606973316', 5, 177);
INSERT INTO public.users VALUES (28, 'user_1675606980746', 2, 12);
INSERT INTO public.users VALUES (27, 'user_1675606980747', 5, 305);
INSERT INTO public.users VALUES (30, 'user_1675606983602', 2, 696);
INSERT INTO public.users VALUES (29, 'user_1675606983603', 5, 297);
INSERT INTO public.users VALUES (32, 'user_1675606988252', 2, 352);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 32, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

