## ✅ Step-by-Step: Install OpenSSH on Ubuntu

### 🔧 Step 1: Update Package List

```bash
sudo apt update
```

---

### 🔧 Step 2: Install OpenSSH Server

```bash
sudo apt install -y openssh-server
```

---

### 🔍 Step 3: Verify SSH Service

Check if the SSH service is running:

```bash
sudo systemctl status ssh
```

Expected output (look for "active (running)"):

```plaintext
● ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service; enabled)
   Active: active (running)
```

---

### 🔁 Step 4: Enable SSH to Start on Boot

```bash
sudo systemctl enable ssh
```

---

### 🌐 Step 5: Check SSH Port (Default: 22)

```bash
ss -tnlp | grep ssh
```

You should see something like:

```plaintext
LISTEN  0  128  0.0.0.0:22  ...
```

---

### 🔓 Step 6: Allow SSH Through Firewall (Optional)

If you're using UFW (Uncomplicated Firewall):

```bash
sudo ufw allow ssh
sudo ufw enable
```

---

### 💻 Step 7: Connect via SSH from Another Machine

```bash
ssh username@your-server-ip
```

---

### 📁 Config File (Optional Tweaks)

Edit the SSH config file:

```bash
sudo nano /etc/ssh/sshd_config
```

Common settings to modify:

* `Port 22` → change to another port for security
* `PermitRootLogin no`
* `PasswordAuthentication no` (if using key-based login)

After changes:

```bash
sudo systemctl restart ssh
```
