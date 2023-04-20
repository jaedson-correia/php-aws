#!/bin/bash
yum update -y
amazon-linux-extras enable postgresql13
/usr/bin/postgresql-setup --initdb

cat <<'EOF' > /var/lib/pgsql/data/pg_hba.conf
${pg_hba_file}
EOF

systemctl enable postgresql
systemctl start postgresql