CREATE TABLE "gclasses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "gclass" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "managers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "manager_id" integer, "name" varchar(255), "password" varchar(255), "deadline" datetime, "group" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "students" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "student_id" integer, "name" varchar(255), "subject" varchar(255), "gclass" varchar(255), "grade" integer, "note" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "subjects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "subject" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "teachers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "teacher_id" integer, "name" varchar(255), "subject" varchar(255), "gclass" varchar(255), "password" varchar(255), "group" integer, "created_at" datetime, "updated_at" datetime, "date_of_submission" date, "submitted" boolean);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120629170107');

INSERT INTO schema_migrations (version) VALUES ('20120629170233');

INSERT INTO schema_migrations (version) VALUES ('20120629170300');

INSERT INTO schema_migrations (version) VALUES ('20120629170321');

INSERT INTO schema_migrations (version) VALUES ('20120629170330');

INSERT INTO schema_migrations (version) VALUES ('20120710161347');

INSERT INTO schema_migrations (version) VALUES ('20120710161447');