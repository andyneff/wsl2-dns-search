
if ! sudo supervisorctl status &> /dev/null; then
  sudo supervisord -c /etc/supervisor/supervisord.conf
fi