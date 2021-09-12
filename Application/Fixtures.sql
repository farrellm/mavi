

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.games DISABLE TRIGGER ALL;



ALTER TABLE public.games ENABLE TRIGGER ALL;


ALTER TABLE public.game_states DISABLE TRIGGER ALL;



ALTER TABLE public.game_states ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, username) VALUES ('eddd8608-d61a-408e-8439-616b4dbc744a', 'farrellm@alum.mit.edu', 'sha256|17|Eqysar6L0uAcejyDHWNVag==|aTGF6HmPi12rCZHvAdJWaxLLYSPAfUbVWIpa5qjZZcI=', NULL, 0, '');


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.players DISABLE TRIGGER ALL;



ALTER TABLE public.players ENABLE TRIGGER ALL;


