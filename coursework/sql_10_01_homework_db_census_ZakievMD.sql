-- sql_10_homework_db_census_ZakievMD.sql
--db_census + db_persons

-- Тема "Перепись населения"
-- Навеяна проведенной переписи начеления 15.10.2021-14.11.2021
-- Поля для проектирования таблиц из форм переписных листов из Постановления Правительства.
-- Объем работы большой, поэтому многое пришлось упростить (иначе эта курсовая затянулась бы надолго).
-- Для обеспечения безопасности персональных данных сделал разделение на 2 БД
-- db_persons - состоит из одной таблицы persons, в которой хранятся персональные данные,
-- в БД db_census внешний ключ на db_persons.persons(person_id)
-- Генерируемая/вычисляемая колонка "age"(возраст) вычисляет возраст участника переписи на 15.11.2021
-- Не получилось реализовать получение в таблицу db_census.profiles из таблицы db_persons.persons,
-- поэтому дата рождения и возраст присутствуют в обоих этих таблицах.
-- Таблица households (домохозяйства) в процессе проектирования и переосмысления оказалась лишней,
-- но не стал её удалять - возможно (когда-нибудь) добавлю что-то, что исключил ранее когда упрощал базу.


-- ------------------------------------------------------------------------------------------------------------------------------- db_persons
-- Создание базы данных db_persons
DROP DATABASE IF EXISTS db_persons;
CREATE DATABASE db_persons;
USE db_persons;

-- В базе "db_persons" создать таблицу "persons" с колонками: "Фамилия", "Имя", "Отчество", "дата рождения", age
DROP TABLE IF EXISTS persons;
CREATE TABLE persons(
    person_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL INVISIBLE COMMENT 'Имя', -- Имя. Самое длинное имя в России 15 букв, в мире 1478 б.
    lastname VARCHAR(50) NOT NULL INVISIBLE COMMENT 'Фамилия', -- Фамилия. Самая длинная фамилия в России 33 буквы, в мире 700 б.
    patronymic VARCHAR(60) DEFAULT 'Нет отчества' INVISIBLE COMMENT 'Отчество', -- Отчество
    birthday DATE INVISIBLE COMMENT 'дата рождения', -- дата рождения'
    age SMALLINT UNSIGNED GENERATED ALWAYS AS (timestampdiff(YEAR,`birthday`,_utf8mb4'2021-11-15')) STORED
);
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- ------------------------------------------------------------------------------------------------------------------------------- db_census
-- Создание базы данных
DROP DATABASE IF EXISTS db_census;
CREATE DATABASE db_census;
USE db_census;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- 1. Создание несвязанных таблиц - без внешних ключей

-- 1.1
-- список субъектов РФ
DROP TABLE IF EXISTS federal_subjects;
CREATE TABLE federal_subjects(
    federal_subject_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    federal_subject_name VARCHAR(40) NOT NULL DEFAULT '0' UNIQUE COMMENT 'Название субъекта РФ'
) COMMENT 'Таблица federal_subjects - Список субъектов РФ';

SHOW TABLES;
DESC federal_subjects;
SHOW CREATE TABLE federal_subjects\G
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 2.1
-- населенные пункты
DROP TABLE IF EXISTS localities;
CREATE TABLE localities(
    locality_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    locality_name VARCHAR(100) NOT NULL DEFAULT '0' COMMENT 'Название населенного пункта',
    federal_subject SMALLINT UNSIGNED NOT NULL, -- Субъект РФ к которому относится населенный пункт

    -- PRIMARY KEY (locality_id, federal_subject), -- составной PRIMARY KEY
    INDEX locality_name_idx(locality_name),
    UNIQUE locality_id_federal_subject_id_idx(locality_id, federal_subject), -- составной уникальный ключ = населенный пункт + субъект РФ
    FOREIGN KEY (federal_subject) REFERENCES federal_subjects(federal_subject_id) -- внешний ключ из таблицы federal_subjects
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) COMMENT 'Таблица localities - Список населенных пунктов связанных с субъектами РФ';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.2
-- список типов жилища
DROP TABLE IF EXISTS housing_types;
CREATE TABLE housing_types(
    housing_type_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    housing_type_name VARCHAR(100) NOT NULL DEFAULT '0' UNIQUE COMMENT 'Название типа жилища' -- название типа жилища
) COMMENT 'Таблица housing_types - Список типов жилища';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.3
-- список "роли в семье"
DROP TABLE IF EXISTS family_roles;
CREATE TABLE family_roles(
    family_role_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    family_role_name VARCHAR(30) NOT NULL DEFAULT '0' UNIQUE COMMENT 'роль в семье' -- роль в семье
) COMMENT 'Таблица family_roles - Список ролей в семье';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.4
-- Список-справочник национальностей
DROP TABLE IF EXISTS ethnic_groups;
CREATE TABLE ethnic_groups(
    ethnic_group_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ethnic_group_name VARCHAR(30) NOT NULL UNIQUE COMMENT 'национальная принадлежность' -- национальная принадлежность
) COMMENT 'Таблица ethnic_groups - Список-справочник национальностей';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.5
-- Таблица countries "Страны" (соотносится с person - гражданство и страна откуда прибыл)
DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
    country_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 193 страны TINYINT максимум 255. TINYINT не поддерживается PostgreSQL
    country_name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Наименование страны' -- наименование страны
) COMMENT 'Таблица countries - Список-справочник стран';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.6
-- Список-справочник языков
DROP TABLE IF EXISTS list_languages;
CREATE TABLE list_languages(
    language_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(55) NOT NULL UNIQUE COMMENT 'Название языка' -- Название языка
) COMMENT 'Таблица list_languages - Список-справочник языков';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.7
-- educations список видов образования
DROP TABLE IF EXISTS educations;
CREATE TABLE educations(
    education_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    education_name VARCHAR(25) NOT NULL UNIQUE COMMENT 'Наименование вида образования' -- Наименование вида образования
) COMMENT 'Таблица educations - Список видов образования';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.8
-- Список-справочник "занятость"
DROP TABLE IF EXISTS employments;
CREATE TABLE employments(
    employment_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employment_type VARCHAR(34) NOT NULL UNIQUE COMMENT 'Наименование вида занятости' -- Наименование вида занятости
) COMMENT 'Таблица employments - Список-справочник видов занятости';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 1.9
-- list_income_sources Список источников дохода
DROP TABLE IF EXISTS list_income_sources;
CREATE TABLE list_income_sources(
    income_source_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    income_source_name VARCHAR(51) NOT NULL UNIQUE COMMENT 'Наименование источника дохода' -- Наименование вида занятости
) COMMENT 'Таблица employments - Список видов источников дохода';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

DROP TABLE IF EXISTS housing_types;
CREATE TABLE housing_types(
    housing_type_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    housing_type_name VARCHAR(21) NOT NULL DEFAULT '0' UNIQUE COMMENT 'Название типа жилища' -- название типа жилища
) COMMENT 'Таблица housing_types - Список типов жилища';
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- создание индексов для полнотекстового поиска:

-- #1 federal_subjects(federal_subject_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX fed_subject_name_fulltext ON federal_subjects (federal_subject_name);

-- #2 localities(locality_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX locality_name_fulltext ON localities (locality_name);

-- #3 housing_types(housing_type_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX housing_type_name_fulltext ON housing_types (housing_type_name);

-- #4 family_roles (family_role_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX family_role_name_fulltext ON family_roles (family_role_name);

-- #5 ethnic_groups (ethnic_group_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX ethnic_group_name_fulltext ON ethnic_groups (ethnic_group_name);

-- #6 countries (country_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX country_name_fulltext ON countries (country_name);

-- #7 list_languages (language_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX language_name_fulltext ON list_languages (language_name);

-- #8 educations (education_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX education_name_fulltext ON educations (education_name);

-- #9 employments (employment_type): FULLTEXT INDEX
CREATE FULLTEXT INDEX employment_type_fulltext ON employments (employment_type);

-- #10 list_income_sources (income_source_name): FULLTEXT INDEX
CREATE FULLTEXT INDEX income_source_name_fulltext ON list_income_sources (income_source_name);
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- -----------------------------------------------------------
-- 3. Создание таблиц связанных с таблицами из первой и второй групп

-- 3.1
-- адрес

DROP TABLE IF EXISTS addresses;
CREATE TABLE addresses(
    address_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    locality INT UNSIGNED NOT NULL,
    street_name VARCHAR(50), -- название улицы
    house_number SMALLINT UNSIGNED NOT NULL, -- номер дома
    flat_number SMALLINT UNSIGNED NOT NULL DEFAULT 0, -- номер квартиры, 0- нет номера квартиры (частный дом)
    housing_type SMALLINT UNSIGNED NOT NULL, -- тип жилища

    INDEX house_number_idx(house_number), -- индексу по номеру дома

    FULLTEXT KEY street_name_fulltext (street_name), -- полнотекстовый индекс по названию улицы

    UNIQUE address_locality_idx(address_id, locality, street_name, house_number, flat_number, housing_type), -- составной уникальный ключ = населенный пункт + улица + дом + квартира + тип жилища
    FOREIGN KEY (locality) REFERENCES localities(locality_id), -- внешний ключ из таблицы localities
    FOREIGN KEY (housing_type) REFERENCES housing_types(housing_type_id) -- внешний ключ из таблицы housing_types
);
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
3. В основной базе "db_census" 
- создать таблицу "profiles":
*/
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
    profile_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,

    xbirthday DATE INVISIBLE COMMENT 'дата рождения', -- дата рождения
	age SMALLINT UNSIGNED GENERATED ALWAYS AS (timestampdiff(YEAR,`xbirthday`,_utf8mb4'2021-11-15')) STORED,
-- age SMALLINT UNSIGNED

    gender ENUM('m', 'f') NOT NULL COMMENT 'пол', -- пол
    education SMALLINT UNSIGNED NOT NULL COMMENT 'образование', -- образование
    sitizenship SMALLINT UNSIGNED NOT NULL COMMENT 'гражданство', -- гражданство
    arrived_from SMALLINT UNSIGNED NOT NULL COMMENT 'из какой страны прибыл', -- из какой страны прибыл
    russian BOOLEAN NOT NULL DEFAULT 1 COMMENT 'знание русского языка', -- знание русского языка
    ethnic_group SMALLINT UNSIGNED NOT NULL COMMENT 'национальная пренадлежность', -- национальная принадлежность
    employment SMALLINT UNSIGNED NOT NULL COMMENT 'занятость',

    PRIMARY KEY (profile_id), -- PRIMARY KEY
    FOREIGN KEY (profile_id) REFERENCES db_persons.persons(person_id), -- внешний ключ из таблицы educations

    FOREIGN KEY (education) REFERENCES educations(education_id), -- внешний ключ из таблицы educations
    FOREIGN KEY (sitizenship) REFERENCES countries(country_id), -- внешний ключ из таблицы countries
    FOREIGN KEY (arrived_from) REFERENCES countries(country_id), -- внешний ключ из таблицы countries
    FOREIGN KEY (ethnic_group) REFERENCES ethnic_groups(ethnic_group_id), -- внешний ключ из таблицы ethnic_groups
    FOREIGN KEY (employment) REFERENCES employments(employment_id) -- внешний ключ из таблицы employments
) COMMENT 'Таблица profiles';
DESC profiles;
SHOW CREATE TABLE profiles\G
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.2
-- домохозяйства
DROP TABLE IF EXISTS households;
CREATE TABLE households(
    household_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    address INT UNSIGNED NOT NULL,

    UNIQUE household_id_address_idx(household_id, address),
    FOREIGN KEY (address) REFERENCES addresses(address_id) -- внешний ключ из таблицы addresses
) COMMENT 'Таблица households - домохозяйства';
SHOW CREATE TABLE households\G
DESC households;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.4
-- person_languages
DROP TABLE IF EXISTS person_languages;
CREATE TABLE person_languages(
    person_language_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    profile INT UNSIGNED NOT NULL,
    language_other SMALLINT UNSIGNED NOT NULL, -- ??????????????????? 1='Нет'

    FOREIGN KEY (profile) REFERENCES profiles(profile_id), -- внешний ключ из таблицы persons
    FOREIGN KEY (language_other) REFERENCES list_languages(language_id) -- внешний ключ из таблицы list_languages
) COMMENT 'Таблица person_languages - персона-языки';
SHOW CREATE TABLE person_languages\G
DESC person_languages;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.5
-- person_income_sources
DROP TABLE IF EXISTS person_income_sources;
CREATE TABLE person_income_sources(
    person_income_source_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    profile INT UNSIGNED NOT NULL,
    income_source SMALLINT UNSIGNED NOT NULL, -- источник дохода

    FOREIGN KEY (profile) REFERENCES profiles(profile_id), -- внешний ключ из таблицы persons
    FOREIGN KEY (income_source) REFERENCES list_income_sources(income_source_id) -- внешний ключ из таблицы list_income_sources
) COMMENT 'Таблица person_income_sources - персона-источники дохода';
SHOW CREATE TABLE person_income_sources\G
DESC person_income_sources;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- 3.6
-- состав домохозяйства
DROP TABLE IF EXISTS household_members;
CREATE TABLE household_members(
    hm_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    household INT UNSIGNED NOT NULL, -- домохозяйство
    profile INT UNSIGNED NOT NULL,
    family_role SMALLINT UNSIGNED NOT NULL,

    UNIQUE profile_family_role_idx(hm_id, household, profile, family_role), -- составной уникальный ключ = профиль + домохозяйство + роль в семье

    FOREIGN KEY (household) REFERENCES households(household_id), -- внешний ключ из таблицы households
    FOREIGN KEY (profile) REFERENCES profiles(profile_id), -- внешний ключ из таблицы persons
    FOREIGN KEY (family_role) REFERENCES family_roles(family_role_id) -- внешний ключ из таблицы family_roles
) COMMENT 'Таблица household_members - состав домохозяйства';
SHOW CREATE TABLE household_members\G
DESC household_members;

UNIQUE profile_family_role_idx(profile, family_role), -- составной уникальный ключ = профиль + роль в семье
UNIQUE
UNIQUE locality_id_federal_subject_id_idx(locality_id, federal_subject), -- составной уникальный ключ = населенный пункт + субъект РФ

CREATE FULLTEXT INDEX fed_subject_name_fulltext ON federal_subjects (federal_subject_name);
    FULLTEXT KEY street_name_fulltext (street_name), -- полнотекстовый индекс по названию улицы
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- изменить колонку xbirthday в таблице profiles:
-- xbirthday DATE INVISIBLE COMMENT 'дата рождения', -- дата рождения
ALTER TABLE profiles MODIFY xbirthday DATE NOT NULL DEFAULT 0 INVISIBLE COMMENT 'дата рождения';


-- изменить колонку sitizenship в таблице profiles:
-- sitizenship SMALLINT UNSIGNED NOT NULL COMMENT 'гражданство', -- гражданство
ALTER TABLE profiles MODIFY sitizenship SMALLINT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'гражданство';

-- изменить колонку arrived_from в таблице profiles:
-- arrived_from SMALLINT UNSIGNED NOT NULL COMMENT 'из какой страны прибыл', -- из какой страны прибыл
-- ALTER TABLE profiles MODIFY arrived_from SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'из какой страны прибыл';
ALTER TABLE profiles MODIFY arrived_from SMALLINT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'из какой страны прибыл';

-- Добавил уникальный индекс (UNIQUE INDEX) для поля "profile" в таблице "household_members"
CREATE UNIQUE INDEX household_members_profile_un_idx ON household_members (profile);

-- добавить комментарий к таблице db_census.addresses
-- ALTER TABLE db_census.addresses COMMENT='Таблица addresses - таблица адресов';
ALTER TABLE addresses COMMENT='Таблица addresses - таблица адресов';
