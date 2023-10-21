mod generated_flatbuffers;
use generated_flatbuffers::monster_generated::my_game::sample::{
                                             Color, Equipment,
                                             Monster, MonsterArgs,
                                             Vec3};

fn main() {
    println!("Hello, world!");

    let mut builder = flatbuffers::FlatBufferBuilder::with_capacity(1024);
    let name = builder.create_string("Orc");
    let orc = Monster::create(&mut builder, &MonsterArgs{
        pos: Some(&Vec3::new(1.0f32, 2.0f32, 3.0f32)),
        mana: 150,
        hp: 80,
        name: Some(name),
        inventory: None,
        color: Color::Red,
        weapons: None,
        equipped_type: Equipment::Weapon,
        equipped: None,
        path: None,
        ..Default::default()
    });
    builder.finish(orc, None);
    let buf = builder.finished_data();
    println!("Buffer size: {}", buf.len())
}
