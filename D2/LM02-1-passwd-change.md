### ✅ Method 1: Using Rails Console (Recommended if GitLab is installed)

Run these commands:

```bash
# Enter the GitLab Rails console
sudo gitlab-rails console

# Inside the console, run:
user = User.where(id: 1).first
user.password = 'NewSecurePassword123'
user.password_confirmation = 'NewSecurePassword123'
user.save!

# Exit the console
exit
```

✅ You will see `true` if the password was successfully updated.

---

### ✅ Method 2: If You Just Installed and Haven’t Set Password

After installation, GitLab may prompt you to set a password at:

```
http://<your-server-ip>/
```

If not, use the Rails console method above.

---

### ✅ Method 3: If GitLab Web Interface is Accessible

* Login as `root`
* Go to **Admin Area → Users → root**
* Set a new password in the user settings

---

### 🔒 Pro Tips

* Avoid using weak or default passwords.
* Restart GitLab services after password reset (optional):

```bash
sudo gitlab-ctl restart
```

