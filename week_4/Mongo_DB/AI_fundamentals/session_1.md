# AI Fundamentals — Session 1: Demystifying AI

## What is AI?
- **Artificial Intelligence (AI)** is the broad field of making machines perceive, reason, learn, and act.
- AI learns patterns from data and uses them to:
  - Identify information
  - Analyse data
  - Manipulate data
  - Create new content
- Everyday examples include chatbots, recommendations, browser summaries, coding assistants, healthcare tools, and data analytics.

## Key terminology

| Term | Meaning |
|---|---|
| **AI** | Umbrella field for intelligent machine behaviour.  |
| **Machine Learning (ML)** | Models learn patterns from data rather than following fixed human-written rules.  |
| **Deep Learning** | ML using multi-layered neural networks to process data such as images, audio, and text.  |
| **Generative AI** | Deep-learning AI that creates new content, such as text, images, or code.  |
| **Traditional AI** | AI trained for one specific task. |
| **Modern AI** | General-purpose, adaptable AI that can handle different tasks without full retraining.  |

### Traditional vs modern AI
- **Traditional AI examples:** narrow customer-service chatbots, film recommenders, specialist in-house tools. 
- **Modern AI examples:** ChatGPT, Claude, Gemini, and other LLM-based assistants. 
- The cat-vs-dog classifier is **traditional AI** because it performs one narrow classification task. 

## How AI learns

| Approach | What it learns | Example |
|---|---|---|
| **Decision trees** | Rules from data | Accepting or rejecting applications based on conditions |
| **Neural networks** | Patterns from data | Recognising cats and dogs in images |
| **Statistical models** | Relationships between variables | Predicting house prices from property features |

Most modern AI systems are built using **neural networks**. 

## Neural networks
- A neural network contains interconnected **nodes** arranged in layers. 
- Main structure:
  - **Input layer:** receives data
  - **Hidden layers:** process patterns and features
  - **Output layer:** produces the prediction or response 
- The network learns by adjusting the **weights**, or connection strengths, between nodes. 

### Common architectures

| Architecture | Full name | Best for |
|---|---|---|
| **CNN** | Convolutional Neural Network | Images, computer vision, image classification |
| **FNN** | Feed-Forward Neural Network | Structured data and general prediction |
| **RNN** | Recurrent Neural Network | Sequential data, language, and time series |

- The **architecture** is the blueprint.
- The **model** is the trained neural network ready to perform a task. 

## Training methods

| Method | Data used | How it works | Example |
|---|---|---|---|
| **Supervised learning** | Labelled data with known answers | Compares predictions with correct outputs and adjusts | Predicting house prices from labelled sales data |
| **Unsupervised learning** | Unlabelled data | Finds patterns, relationships, and groups independently | Grouping songs by musical characteristics |
| **Reinforcement learning** | Feedback signals | Learns through rewards and penalties | Thumbs-up/down feedback on AI responses |

- **Supervised learning** needs labelled examples, such as images stored in `cat` and `dog` folders. [1][2]
- **Unsupervised learning** is useful when labels do not already exist, though humans may still validate the resulting groups. [2]
- **Reinforcement learning** uses numerical rewards for good outcomes and penalties for bad outcomes. [1][2]

## Inference
- **Inference** is using a trained model on new, unseen data to produce an output. [1][2]
- Example: after training on house prices, the model estimates the price of a new three-bedroom house. [2]
- A model may need updating if it becomes:
  - **Inaccurate**
  - **Biased**
  - **Out of date** [1][2]
- Solutions include retraining with better data or replacing the model with a newer version. [1][2]

## CNN demo: cat vs dog classifier
- **Task:** classify images as either a cat or a dog. [1][2]
- **Architecture used:** CNN, because CNNs are best suited to image data. [1][2]
- **Tech stack:** Python, TensorFlow, and Keras. [1][2]
- **Learning type:** supervised learning, because folder names acted as labels. [1][2]

### CNN layers
- Early layers detect simple visual features such as edges, colour, and contrast. [2]
- Middle layers detect shapes, textures, curves, and fur patterns. [2]
- Later layers detect larger structures such as eyes, ears, faces, and body shape. [2]
- The output layer predicts either `cat` or `dog`. [2]

## Training process
- Images are separated into labelled folders, such as `cat` and `dog`. [1][2]
- The dataset is split into:
  - **Training data:** used to teach the model
  - **Validation data:** held back to test generalisation [2]
- In the demo, 20% of images were used for validation. [2]
- **Augmentation** modifies training images through flipping, rotation, and zooming to improve robustness. [2]
- An **epoch** is one full pass through the training dataset. [2]
- Too many epochs can cause **overfitting**, where the model memorises training examples instead of learning general patterns. [2]
- **Accuracy** measures correct predictions; **loss** measures prediction error, with lower loss being better. [2]

## Why the model made mistakes
- The first model classified a black cat as a dog. [2]
- The likely cause was dataset bias: cats were mostly lighter-coloured and dogs mostly darker-coloured. [2]
- The CNN therefore relied partly on colour rather than true animal features. [2]
- Adding more varied images and using colour-related augmentation, such as random brightness and contrast, could reduce this problem. [1][2]

## Key lesson: data quality
- **AI is only as good as its training data.** [1][2]
- A good dataset must be both:
  - **Large**
  - **Varied** [1][2]
- Variety should include different colours, poses, angles, lighting conditions, and backgrounds. [2]
- A model can be very confident and still wrong, so confidence scores alone do not guarantee correctness. [2]


