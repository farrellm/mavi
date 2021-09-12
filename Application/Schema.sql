-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TYPE Kit AS ENUM ('azul', 'cant_stop');
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE games (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    kit Kit NOT NULL
);
CREATE TABLE players (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    game_id UUID NOT NULL,
    user_id UUID NOT NULL
);
CREATE INDEX players_game_id_index ON players (game_id);
CREATE INDEX players_user_id_index ON players (user_id);
CREATE TABLE game_states (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    game_id UUID NOT NULL,
    state JSONB NOT NULL
);
CREATE INDEX game_states_game_id_index ON game_states (game_id);
ALTER TABLE game_states ADD CONSTRAINT game_states_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE;
ALTER TABLE players ADD CONSTRAINT players_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE;
ALTER TABLE players ADD CONSTRAINT players_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
