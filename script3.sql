drop table if exists courses, reviews;

create table courses
(
    id int primary key generated by default as identity,
    name text,
    description text
);

create table reviews
(
    id int primary key generated by default as identity,
    id_course int references courses(id),
    text_review text,
    mark int
);

insert into courses (name, description)
values
    ('Курс А', 'Обучение'),
    ('Курс Б', 'Здоровье'),
    ('Курс С', 'Счастье');

insert into reviews (id_course, text_review, mark)
values
    (1, 'Хороший курс',6),
    (1, 'Мне понравилось', 8),
    (3, 'Идеально', 10);

select
    cour.id,
    cour.name,
    cour.description,
    coalesce(json_agg(json_build_object('text_review', rev.text_review, 'mark', rev.mark))
             filter (where rev.id is not null), '[]') as revi

from courses as cour
         left join reviews rev on cour.id = rev.id_course
group by cour.id;



