create table requirements (
  id text primary key,
  description text not null,
  rationale text
);

create table traces (
  tracee text,
  traced text,
  foreign key (tracee) references requirements (id),
  foreign key (traced) references requirements (id),
  primary key (tracee, traced)
);

insert into requirements values
  ('hello.low.1', 'It must work', 'Because things need to work.'),
  ('hello.high.2','Everything must work.','Because everythin needs to work');

insert into traces values
  ('hello.low.1', 'hello.high.2');
