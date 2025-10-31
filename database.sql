create type enrollments_status as enum('active', 'pending', 'cancelled', 'completed');
create type payments_status as enum('pending', 'paid', 'failed', 'refunded');
create type program_status as enum('active', 'completed', 'pending', 'cancelled');
create type blog_status as enum('created', 'in moderation', 'published', 'archived');
create table courses (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			created_at timestamp not null, 
			updated_at timestamp not null,
			deleted_at timestamp
			);
create table modules (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			created_at timestamp not null, 
			updated_at timestamp not null,
			deleted_at timestamp
			);
create table lessons (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			content text not null, 
			video_url varchar(255), 
			position int, 
			created_at timestamp not null, 
			updated_at timestamp not null, 
			course_id bigint references courses(id),
			deleted_at timestamp
			);
create table programs (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			price decimal (10,2), 
			program_type varchar(255) not null, 
			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table course_modules (
				primary key (module_id, course_id), 
				module_id bigint references modules(id) not null, 
				course_id bigint references courses(id) not null
				);
create table program_modules (
				primary key (module_id, program_id), 
				module_id bigint references modules(id) not null, 
				program_id bigint references programs(id) not null
				);
create table teaching_groups (
  				id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  				slug varchar(255) not null,
  				created_at timestamp not null, 
				updated_at timestamp not null
  				);
create table users (
  			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  			name varchar(255) not null,
  			email varchar(255) not null,
  			password_hash varchar(255),
  			teaching_group_id bigint references teaching_groups (id) not null,
  			role varchar(20) not null,
  			created_at timestamp not null, 
			updated_at timestamp not null,
			deleted_at timestamp
  			);
create table enrollments (
  				id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  				user_id bigint references users(id) not null,
  				program_id bigint references programs(id) not null,
  				status enrollments_status not null,
                            	created_at timestamp not null, 
				updated_at timestamp not null
                            );
create table payments (
  			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  			enrollment_id bigint references enrollments(id) not null,
  			amount numeric(10,2) not null,
  			status payments_status not null,
  			paid_at timestamp not null,
  			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table program_completions (
  					id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  					user_id bigint references users(id) not null,
  					program_id bigint references programs(id) not null,
  					status program_status not null,
  					started_at date,
  					completed_at date,
  					created_at timestamp not null, 
					updated_at timestamp not null
					);
create table certificates (
  				id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  				user_id bigint references users(id) not null,
  				program_id bigint references programs(id) not null,
  				url text not null,
  				issued_at date not null,
  				created_at timestamp not null, 
				updated_at timestamp not null
				);
create table quizzes (
  			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  			lesson_id bigint references lessons(id) not null,
  			name varchar(255) not null,
  			content jsonb not null,
  			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table exercises (
  			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  			lesson_id bigint references lessons(id) not null,
  			name varchar(255) not null,
  			url text not null,
  			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table discussions (
  				id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  				lesson_id bigint references lessons(id) not null,
  				user_id bigint references users(id) not null,
				text text not null,
  				created_at timestamp not null, 
				updated_at timestamp not null
				);
create table blogs (
  			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  			user_id bigint references users(id) not null,
  			name varchar(255) not null,
  			content text not null,
  			status blog_status not null,
  			created_at timestamp not null, 
			updated_at timestamp not null
			);
