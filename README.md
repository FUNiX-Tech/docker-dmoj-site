# Dmoj docker compose cho phần site

`make buildnew`: build với db mới.
`make buildold`: build với db cũ (sẽ không có câu lệnh tạo bảng navbar, ngôn ngữ lập trình, data demo).

Khi chạy câu lệnh trên sẽ fetch git repo về để build.

### Cách config

Tạo folder `problems` và `db` cho volume ở thư mục gốc.

Sửa các config trong `site.env`, `db.env`, `site`, `compose.yml`.
