create table Courses (id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, name varchar(255) not null, description text not null, created_at timestamp not null, updated_at timestamp not null);
