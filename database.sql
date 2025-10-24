create type enrollments_status as enum('active', 'pending', 'cancelled', 'completed');
create type payments_status as enum('pending', 'paid', 'failed', 'refunded');
create type program_status as enum('active', 'completed', 'pending', 'cancelled');
create table courses (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			created_at timestamp not null, 
			updated_at timestamp not null,
			is_active boolean not null
			);
create table modules (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			created_at timestamp not null, 
			updated_at timestamp not null,
			is_active boolean not null
			);
create table lessons (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			description text not null, 
			video_link varchar(255), 
			lesson_number int not null, 
			created_at timestamp not null, 
			updated_at timestamp not null, 
			course_id bigint references courses(id) not null,
			is_active boolean not null
			);
create table programs (
			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
			name varchar(255) not null, 
			program_cost decimal (10,2), 
			program_type varchar(255) not null, 
			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table module_to_curse (
				primary key (module_id, course_id), 
				module_id bigint references modules(id) not null, 
				course_id bigint references courses(id) not null
				);
create table module_to_program (
				primary key (module_id, program_id), 
				module_id bigint references modules(id) not null, 
				program_id bigint references programs(id) not null
				);
create table teaching_groups (
  				id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  				slag varchar(255) not null,
  				created_at timestamp not null, 
				updated_at timestamp not null
  				);
create table users (
  			id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  			name varchar(255) not null,
  			email varchar(255) not null,
  			password varchar(255) not null,
  			teaching_group_id bigint references teaching_groups (id) not null,
  			type varchar(20) not null,
  			created_at timestamp not null, 
			updated_at timestamp not null
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
  			payment_day timestamp not null,
  			created_at timestamp not null, 
			updated_at timestamp not null
			);
create table program_completions (
  					id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  					user_id bigint references users(id) not null,
  					program_id bigint references programs(id) not null,
  					status program_status not null,
  					start_date date not null,
  					end_date date,
  					created_at timestamp not null, 
					updated_at timestamp not null
					);
