# Dmoj docker compose cho phần site

`make buildnew`: build với db mới.
`make buildold`: build với db cũ (sẽ không có câu lệnh tạo bảng navbar, ngôn ngữ lập trình, data demo).

Khi chạy câu lệnh trên sẽ fetch git repo về để build.

### Cách config

Đổi tên `empty.db` thành `db`.
Đổi tên `empty.problems` thành `problems`.

Sửa các config trong `site.env`, `db.env`, `site`, `compose.yml`.
