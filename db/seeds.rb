
u = User.create(name: "Bob", email: "bob@bob.com", password_digest: "abc")

c = Character.create(name: "John The Great")

a = Archatype.create(name: "wizard", description: "Old wise greybeard")

pow = Power.create(name: "Fireball", effect: "burn")

a.power_ids = pow.id

c.archatype_ids = a.id

c.user = u

l = Location.create(name: "Magical Forest", description: "a heavily wooded glen, full of ferns and abundant wildlife", weather: "Plesant", housing: "a few sparsely clustered homes. Mostly hollowed trees and trehouses slightly expanded to include wood construction and thached leaf roofs")

b = Building.create(name: "High Home", description: "A large circular treehouse, expanded from a crotch in a large tree perched upon a rocky precipace jutting from the side of a hill high upon a vally. It glows imbued wit hthe magical energy of its creation; and creator.", special_properties: "aligned with the setting sun and moon it provides a class bonus to celestial majic. +3 to all woodland spells.")

b.location_id = l.id

c.building_ids = b.id

c.location_ids = l.id

c.save



