use crate::{ws, Client, Clients, Result};
use serde::{Serialize};
use uuid::Uuid;
use warp::{http::StatusCode, reply::json, Reply};

#[derive(Serialize, Debug)]
pub struct HealthCheckResponse {
    healthy: bool,
}

/*
pub async fn publish_handler(body: Event, clients: Clients) -> Result<impl Reply> {
    clients
        .read()
        .await
        .iter()
        .filter(|(_, client)| match body.user_id {
            Some(v) => client.user_id == v,
            None => true,
        })
        .filter(|(_, client)| client.topics.contains(&body.topic))
        .for_each(|(_, client)| {
            if let Some(sender) = &client.sender {
                let _ = sender.send(Ok(Message::text(body.message.clone())));
            }
        });

    Ok(StatusCode::OK)
}
 */

async fn register_client(id: String, user_id: String, clients: Clients) {
    clients.write().await.insert(
        id,
        Client {
            user_id,
            sender: None,
        },
    );
}

pub async fn unregister_handler(id: String, clients: Clients) -> Result<impl Reply> {
    // Todo: Put unregistering in the right place
    clients.write().await.remove(&id);
    Ok(StatusCode::OK)
}

pub async fn ws_handler(ws: warp::ws::Ws, clients: Clients) -> Result<impl Reply> {
    let mut client_write_lock = clients.write().await;

    // Regenerate UUID to make sure it isn't taken
    let mut uuid = Uuid::new_v4().as_simple().to_string();
    while client_write_lock.contains_key(&uuid) {
        uuid = Uuid::new_v4().as_simple().to_string();
    }

    let client = Client {
        user_id: uuid.clone(),
        sender: None,
    };

    client_write_lock.insert(
        uuid.clone(),
        client.clone()
    );
    drop(client_write_lock);

    Ok(ws.on_upgrade(move |socket| ws::client_connection(socket, uuid, clients, client.clone())))
}

pub async fn health_handler() -> Result<impl Reply> {
    Ok(json(&HealthCheckResponse {
        healthy: true,
    }))
}