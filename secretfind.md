
## 6. Redis Status via `redis_exporter` 

Redis status and runtime metrics should be exposed using `redis_exporter`.


### 6.1 Run Redis Exporter

Install the approved `redis_exporter` binary on the VM that can reach Redis.

Example environment file:

```bash
sudo install -m 600 /dev/null /etc/redis-exporter.env
sudo nano /etc/redis-exporter.env
```

Example `/etc/redis-exporter.env`:

```bash
REDIS_ADDR=redis://127.0.0.1:6379
REDIS_PASSWORD=<managed-secret>
```

Example systemd service:

```ini
[Unit]
Description=Prometheus Redis Exporter
Wants=network-online.target
After=network-online.target

[Service]
EnvironmentFile=/etc/redis-exporter.env
ExecStart=/usr/local/bin/redis_exporter --web.listen-address=:9121
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable redis-exporter
sudo systemctl start redis-exporter
sudo systemctl status redis-exporter
```
