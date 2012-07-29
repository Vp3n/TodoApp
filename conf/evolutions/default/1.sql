# --- !Ups
CREATE TABLE todo
(
  id serial NOT NULL,
  label character varying(255) NOT NULL,
  is_done boolean NOT NULL DEFAULT false,
  is_archived boolean DEFAULT false,
  CONSTRAINT pk_todo PRIMARY KEY (id )
);


# --- !Downs
DROP TABLE todo;