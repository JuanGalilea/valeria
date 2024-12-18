create table extra_hours(
    id          serial primary key,
    ingress     timestamp(0) without time zone not null,
    egress      timestamp(0) without time zone not null
);

insert into extra_hours (ingress, egress) values ('2024-09-03', '2024-09-04')