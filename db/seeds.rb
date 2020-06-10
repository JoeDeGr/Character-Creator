
u = User.create(name: "Bob", email: "bob@bob.com", password_digest: "abc")

c = Character.create(name: "John The Great")

a = Archatype.create(name: "wizard", description: "Old wise greybeard")

pow = Power.create(name: "Fireball", effect: "burn")

a.power_ids = pow.id

c.archatype_ids = a.id

c.user = u

c.save

