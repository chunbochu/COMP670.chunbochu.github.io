
## [Rasa NLU Pipeline](https://rasa.com/blog/intents-entities-understanding-the-rasa-nlu-pipeline/)
This article exaplains the majorcomponents ins a Rasa NLU pipelihe.
There are different types of components that you can expect to find in a pipeline. The main ones are:
- Tokenizers
- Featurizers
- Intent Classifiers
- Entity Extractors

### Intent classification with the Rasa DIETClassifier
Now that we have seen how providing good features can impact our training, let's see go through a few knobs we have access to when training. In this section we'll focus on intents.

What is the DIETClassifier and how does it work?

Let's quicky explain how the `DIETClassifier` works, in general and layman's terms:
The model takes different features as inputs:
- Dense features from pre-trained embeddings. Dense features are fed from featurizers upstream in the pipeline. For example the `SpacyFeaturizer` will provide pre-trained embeddings from the Spacy models as features.
- Sparse features from the training data. Sparse features are provided by the `CountVectorsFeaturizers`.
The distinction between dense and sparse features is a technicality: pre-trained vectors are dense because every dimension of the vector contains a number, while features from the training data are sparse because they comes as one-hot vectors: all values are 0 except one which is generally equal to 1.

You don't need to provide both dense and sparse features. You can use pre-trained embeddings, features from your oww training data, or both.

Ref: [Better Intent Classification And Entity Extraction with DIETClassifier Pipeline Optimization](https://botfront.io/blog/better-intent-classification-and-entity-extraction-with-diet-classifier-pipeline-optimization)
