# Periodic Table Database

PostgreSQL database corrections and a Bash element lookup for the freeCodeCamp Relational Databases course.

## Run

In the freeCodeCamp PostgreSQL environment:

```bash
psql -U postgres < periodic_table.sql
chmod +x element.sh
./element.sh 1
./element.sh Ne
./element.sh Fluorine
```

The dump recreates `periodic_table` and expects the `freecodecamp` PostgreSQL role. On another system, create that role or adjust the connection in `element.sh`.

`fix-database.sql` records the migration from the course's original starter database. Use the final dump to restore the completed database; the migration is only for the original starter schema.
