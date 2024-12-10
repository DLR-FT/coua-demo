create table requirements (
  id text primary key,
  description text not null,
  rationale text,
  level text not null
);

create table traces (
  tracee text,
  traced text,
  foreign key (tracee) references requirements (id),
  foreign key (traced) references requirements (id),
  primary key (tracee, traced)
);

insert into requirements values
  ('hello.low.1', 'It must work', 'Because things need to work.', 'low'),
  ('hello.high.2','Everything must work.','Because everything needs to work', 'high');

insert into traces values
  ('hello.low.1', 'hello.high.2');
