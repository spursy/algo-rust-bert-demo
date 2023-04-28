#[allow(unused_imports)]
use rust_bert::pipelines::sentence_embeddings::{
    SentenceEmbeddingsBuilder, SentenceEmbeddingsModelType,
};

fn main() -> anyhow::Result<()> {
    // Set-up local sentence embeddings model
    let local_model = SentenceEmbeddingsBuilder::local("resources/all-MiniLM-L12-v2")
        .with_device(tch::Device::cuda_if_available())
        .create_model()?;
    // Define input
    let local_sentences = ["this is an example sentence", "each sentence is converted"];
    // Generate Embeddings
    let local_embeddings = local_model.encode(&local_sentences)?;
    println!("local embeddings ::: {local_embeddings:?}");

    // Set-up remote sentence embeddings model
    // let model = SentenceEmbeddingsBuilder::remote(SentenceEmbeddingsModelType::AllMiniLmL12V2)
    //     .create_model()?;
    // // Define input
    // let sentences = ["this is an example sentence", "each sentence is converted"];
    // // Generate Embeddings
    // let embeddings = model.encode(&sentences)?;
    // println!("remote embeddings ::: {embeddings:?}");
    Ok(())
}
