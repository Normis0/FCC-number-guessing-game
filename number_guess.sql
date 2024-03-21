--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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
    username character varying(22),
    games_played integer,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('test1', 1, 8);
INSERT INTO public.users VALUES ('user_1711016178714', 2, 484);
INSERT INTO public.users VALUES ('user_1711016178715', 5, 75);
INSERT INTO public.users VALUES ('user_1711016411987', 2, 272);
INSERT INTO public.users VALUES ('user_1711016411988', 5, 98);
INSERT INTO public.users VALUES ('user_1711016508174', 2, 588);
INSERT INTO public.users VALUES ('user_1711016508175', 5, 10);
INSERT INTO public.users VALUES ('user_1711016526795', 2, 887);
INSERT INTO public.users VALUES ('user_1711016526796', 5, 30);
INSERT INTO public.users VALUES ('user_1711016590307', 2, 291);
INSERT INTO public.users VALUES ('user_1711016590308', 5, 5);
INSERT INTO public.users VALUES ('user_1711016593004', 2, 780);
INSERT INTO public.users VALUES ('user_1711016593005', 5, 98);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

