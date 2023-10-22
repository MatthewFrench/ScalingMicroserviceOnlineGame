mod generated_flatbuffers;

use std::collections::HashMap;
use generated_flatbuffers::monster_generated::my_game::sample::{
                                             Color, Equipment,
                                             Monster, MonsterArgs,
                                             Vec3};

use std::convert::Infallible;
use std::sync::Arc;
use tokio::sync::{mpsc, RwLock};
use warp::{ws::Message, Filter, Rejection};

mod handler;
mod ws;

type Result<T> = std::result::Result<T, Rejection>;
type Clients = Arc<RwLock<HashMap<String, Client>>>;

#[derive(Debug, Clone)]
pub struct Client {
    pub user_id: String,
    pub sender: Option<mpsc::UnboundedSender<std::result::Result<Message, warp::Error>>>,
}

#[tokio::main]
async fn main() {
    let clients: Clients = Arc::new(RwLock::new(HashMap::new()));

    let health_route = warp::path!("health").and_then(handler::health_handler);

    let ws_route = warp::path("ws")
        .and(warp::ws())
        .and(with_clients(clients.clone()))
        .and_then(handler::ws_handler);

    let routes = health_route
        .or(ws_route)
        // Todo: Allow any origin may not be a good idea
        .with(warp::cors().allow_any_origin());

    println!("Running websocket server at 127.0.0.1:8000");

    warp::serve(routes).run(([127, 0, 0, 1], 8000)).await;
}

fn with_clients(clients: Clients) -> impl Filter<Extract = (Clients,), Error = Infallible> + Clone {
    warp::any().map(move || clients.clone())
}

fn test_flatbuffers() {
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
    println!("Buffer size: {}", buf.len());
}