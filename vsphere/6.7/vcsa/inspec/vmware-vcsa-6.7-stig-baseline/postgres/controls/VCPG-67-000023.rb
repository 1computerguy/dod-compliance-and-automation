control "VCPG-67-000023" do
  title "The vPostgres database must use UTC for log timestamps."
  desc  "If time stamps are not consistently applied and there is no common
time reference, it is difficult to perform forensic analysis.

    Time stamps generated by the DBMS must include date and time. Time is
commonly expressed in Coordinated Universal Time (UTC), a modern continuation
of Greenwich Mean Time (GMT), or local time with an offset from UTC.

    Some DBMS products offer a data type called TIMESTAMP that is not a
representation of date and time. Rather, it is a database state counter and
does not correspond to calendar and clock time. This requirement does not refer
to that meaning of TIMESTAMP."
  impact 0.5
  tag severity: "CAT II"
  tag component: "postgres"
  tag gtitle: "SRG-APP-000374-DB-000322"
  tag gid: nil
  tag rid: "VCPG-67-000023"
  tag stig_id: "VCPG-67-000023"
  tag cci: "CCI-001890"
  tag nist: ["AU-8 b", "Rev_4"]
  desc 'check', "At the command prompt, execute the following command:

# grep '^\\s*log_timezone\\b' /storage/db/vpostgres/postgresql.conf

If \"log_timezone\" is not \"utc\", this is a finding."
  desc 'fix', "At the command prompt, execute the following commands:

# /opt/vmware/vpostgres/current/bin/psql -U postgres -c \"ALTER SYSTEM SET
log_timezone TO 'UTC';\"

# /opt/vmware/vpostgres/current/bin/psql -U postgres -c \"SELECT
pg_reload_conf();\""

  describe parse_config_file('/storage/db/vpostgres/postgresql.conf') do
    its('log_timezone') { should cmp "'UTC'" }
  end

end

