
if ! sudo supervisorctl status &> /dev/null; then
  if [ -e /etc/supervisor/supervisord.conf ]; then
    sudo supervisord -c /etc/supervisor/supervisord.conf
  elif [ -e /etc/supervisord.conf ]; then
    sudo mkdir -p /run/supervisor
    sudo supervisord -c /etc/supervisord.conf
  else
    # Hope for the best?
    sudo supervisord
  fi
fi
