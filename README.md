# opennic_unbound_updater

## installation

```
# cd /root

# git clone https://github.com/emeric254/opennic_unbound_updater.git

# cp /root/opennic_unbound_updater/opennic_unbound_updater.service /etc/systemd/system/
# cp /root/opennic_unbound_updater/opennic_unbound_updater.timer /etc/systemd/system/

# chmod a+x /root/opennic_unbound_updater/opennic_unbound_updater.sh

# systemctl daemon-reload

# systemctl restart opennic_unbound_updater.service
# systemctl status opennic_unbound_updater.service

# systemctl enable opennic_unbound_updater.timer
# systemctl start opennic_unbound_updater.timer

# systemctl list-timers
```
