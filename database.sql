create table courses (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table modules (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table lessons (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			video_link varchar(255), 
			lesson_number int not null, 
			created_at timestamp not null, 
			updated_at timestamp not null, 
			course_id bigint references courses(id) not null
			);
