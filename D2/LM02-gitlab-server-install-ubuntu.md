
## ✅ Prerequisites

* Ubuntu Server (20.04 or 22.04 recommended)
* 2 vCPUs, 4GB RAM minimum (8GB recommended)
* Root or sudo access
* Static IP / DNS preferred
* Open ports: `22`, `80`, `443`

---

## 🔧 Step 1: Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🔧 Step 2: Install Required Dependencies

```bash
sudo apt install -y curl openssh-server ca-certificates tzdata perl
```

(Optional: for email notifications)

```bash
sudo apt install -y postfix
# Choose "Internet Site" during installation
```

---

## 🔧 Step 3: Add GitLab Repository

```bash
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
```

> ⚠️ Use `gitlab-ce` in the next step if you want the free **Community Edition** instead of Enterprise.

---

## 🔧 Step 4: Install GitLab

Replace `http://private_server_ip` with your actual domain or public IP:

```bash
sudo EXTERNAL_URL="http://private_server_ip" apt install gitlab-ce
sudo EXTERNAL_URL="192.168.163.128" apt install gitlab-ce
```

> If you're using HTTPS, use `https://gitlab.example.com` and ensure certs are ready (or use Let's Encrypt).

---

## 🔧 Step 5: Start and Configure GitLab

After installation, configure GitLab with:

```bash
sudo gitlab-ctl reconfigure
```

---

## ✅ Step 6: Access GitLab

* Open your browser:

  ```
  http://192.168.163.128 
  ```
* You'll be prompted to set the **admin root password** on first login.

---

## 🔐 Step 7: Log In

Default username: `root`
Password: Set during first login

---

## 🛡️ (Optional) Enable HTTPS with Let's Encrypt

Edit config:

```bash
sudo nano /etc/gitlab/gitlab.rb
```

Add or modify:

```ruby
external_url 'https://192.168.163.128'
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['you@example.com'] 
```

Then reconfigure:

```bash
sudo gitlab-ctl reconfigure
```

---

## 🔄 Useful GitLab Commands

| Command                  | Description                     |
| ------------------------ | ------------------------------- |
| `gitlab-ctl status`      | Check GitLab services           |
| `gitlab-ctl restart`     | Restart GitLab services         |
| `gitlab-ctl reconfigure` | Reapply config from `gitlab.rb` |
| `gitlab-ctl tail`        | View logs                       |

---

## 📦 GitLab CE vs EE -- Optional ( not required now)

* CE (Community Edition): Free & open-source
* EE (Enterprise Edition): Requires license, but defaults to free tier unless activated

To install EE instead:

```bash
sudo EXTERNAL_URL="http://private_server_ip" apt install gitlab-ee
```

