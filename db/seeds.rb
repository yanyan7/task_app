User.delete_all
User.create(name: "admin", email: "admin@email.com", password: "admin12", password_confirmation: "admin12", admin: true)
User.create(name: "yan", email: "yan@email.com", password: "yan1234", password_confirmation: "yan1234", admin: false)

admin = User.find_by(name: "admin").id
yan = User.find_by(name: "yan").id

Task.delete_all
Task.create(name: "adminのタスク1", description: "adminのタスク1", user_id: admin)
Task.create(name: "adminのタスク2", description: "adminのタスク2", user_id: admin)
Task.create(name: "yanのタスク1", description: "yanのタスク1", user_id: yan)
Task.create(name: "yanのタスク2", description: "yanのタスク2", user_id: yan)
Task.create(name: "yanのタスク3", description: "yanのタスク3", user_id: yan)