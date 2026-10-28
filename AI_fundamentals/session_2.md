# AI Fundamentals — Session 2: Understanding Modern AI



## What is an LLM?
- **LLM** means **Large Language Model** 
- It is a specialised neural network trained on vast text datasets to understand and generate human language 
- LLMs learn **statistical patterns** from training data and use them to predict likely responses 
- They generate text for:
  - Conversations
  - Fact-finding
  - Code development 

### LLM vs LMM
| Term | Meaning |
|---|---|
| **LLM** — Large Language Model | Trained mainly on text; generates text  |
| **LMM** — Large Multimodal Model | Trained on multimodal data; can process and generate more than text, such as images or audio  |

- Many systems called “LLMs” are actually multimodal, but **LLM** remains the common industry term 

## LLM training data
LLMs are trained on large and varied sources, including:
- Websites and the general web
- Books, journals, and research papers
- News articles
- GitHub code repositories
- Images, audio, and video
- Data in multiple languages [3]

Large, varied datasets help models make better predictions and reduce overfitting [3]

## How an LLM works
LLMs do **not** retrieve facts from a database like a search engine They use learned patterns to predict the most likely response 

### LLM pipeline
1 **Text input** — the user writes a prompt 
2 **Tokenisation** — the prompt is split into tokens, which may be whole words, word parts, or punctuation 
3 **Embedding** — each token is converted into a numerical vector 
4 **Transformer** — multiple layers process the vectors and build context 
5 **Output** — the model predicts and assembles the most likely response 

### Example: “What is the capital of France?”
- The prompt is tokenised into words and punctuation 
- Tokens become numerical vectors 
- Transformer layers identify important tokens such as `capital`, `France`, and `?` 
- Context mixing helps the model understand that “capital” means a country’s principal city, not money or a capital letter 
- The model assigns probabilities to possible next tokens; `Paris` receives the highest probability and is selected 

## Inside the transformer
The transformer is the key architecture behind modern LLMs 

It uses:
- **Attention** — identifies the most important words or tokens in the prompt 
- **Context mixing** — works out how words relate to one another 
- **Feed-forward processing** — updates the interpretation and passes it to the next layer 
- **Repeated layers** — each layer refines the model’s understanding and updates token vectors 

After the final layer, the model calculates a probability distribution over possible next tokens 

## Greedy generation
- The **greedy approach** selects the token with the highest probability each time
- A fully greedy LLM would be **deterministic**: the same prompt would always produce the same answer 
- This is not ideal for natural language because humans give varied responses to open questions 
- For factual questions, high-probability answers are useful; for creative tasks, some variation is preferable 

## Inference parameters
Inference parameters, also called generation parameters, control how an LLM selects tokens 

| Parameter | What it controls | Low setting | High setting |
|---|---|---|---|
| **Temperature** | Randomness | More predictable and factual | More creative and unpredictable |
| **Top-K sampling** | Number of candidate tokens | Keeps fewer likely tokens | Keeps more candidate tokens |
| **Top-P / nucleus sampling** | Cumulative probability threshold | Smaller, more confident token pool | Larger token pool |
| **Presence penalty** | Repetition | Allows repeated words and themes | Discourages repetition and encourages variety |

### Temperature
- **Low temperature** is best for factual, academic, healthcare, or precision-focused tasks 
- **High temperature** is best for brainstorming, creative writing, and conversational tasks 
- Very high temperature can reduce coherence and consistency, so production systems usually use lower settings 

### Top-K vs top-P
- **Top-K** keeps the `K` most likely tokens; for example, Top-20 keeps only the 20 highest-probability tokens 
- **Top-P / nucleus sampling** keeps tokens until their combined probability reaches a set threshold, such as 80% 
- Unlike Top-K, the number of tokens in Top-P changes depending on the model’s confidence 

## Open vs closed LLMs

| Feature | Open LLM | Closed LLM |
|---|---|---|
| Model internals | Exposed or partly exposed | Hidden |
| Inference parameters | Often adjustable | Limited or unavailable |
| Weights | May be downloadable | Not downloadable |
| Deployment | Can often run on own hardware | Managed service only |
| Control | High | Low |

- The **OpenAI API** allows parameter changes but does not provide the model weights or allow local deployment 
- The ChatGPT app provides limited customisation 
- **DeepSeek** is presented as more open: its model weights can be downloaded, it can run on your own hardware, and it offers greater control 

## AI limitations

### Reliability
- LLMs are generally useful but prone to error because outputs are probabilistic 
- Accuracy can vary substantially between models; one cited epidemiology study found model accuracy ranging from 452% to 762% 
- This is especially serious in healthcare, where incorrect advice can cause harm 

### Hallucinations
- A **hallucination** is a false claim, fact, reference, or URL generated by an AI model 
- They occur because the model predicts plausible text rather than verifying facts 
- Example: an LLM may generate an NHS-style URL that looks plausible but does not exist 

### Bias
- LLMs inherit biases from their training data 
- Bias may relate to gender, ethnicity, nationality, or other demographic characteristics 
- Models may reinforce stereotypes if training data is not diverse and balanced 
- Training data can also over-represent Western perspectives 

### Entity disambiguation
- This is when an LLM cannot distinguish between two people, businesses, or places with the same name 
- It can cause serious reputational harm if negative information about one entity is incorrectly linked to another 

### Tokenisation limitations
- LLMs process token vectors, not letters in the way humans see them 
- This makes tasks involving letter composition difficult, such as counting the letters in “strawberry” 
- Asking the model to spell a word out can help it reason through the task 

### Context window
- A **context window** is the amount of information an AI can consider at one time 
- Small context windows make long conversations and large documents harder to handle 
- Large context windows allow more information but increase cost and can cause the model to overlook earlier details or favour recent information 

### Model collapse
- **Model collapse** is the hypothetical risk of repeatedly training AI on AI-generated content 
- It may cause future models to produce repetitive, low-quality, homogenised, or nonsensical output 
- It is linked to the **Dead Internet Theory**, which argues that AI-generated content is increasingly replacing human-created content online 

## Risk mitigation

| Issue | Mitigation |
|---|---|
| **Hallucinations** | Double-check facts and references; use RAG when developing AI systems  |
| **Bias** | Use diverse, balanced, and representative training sources  |
| **Tokenisation limitations** | Ask the model to spell out words so it can reason about letters  |
| **Context window issues** | Summarise key information, remove irrelevant content, and start new chats for unrelated topics  |
| **Model collapse** | Ensure training datasets include a meaningful proportion of human-generated content  |

## RAG
- **RAG** means **Retrieval-Augmented Generation** 
- It is a real-world engineering technique used to improve LLM reliability 

### How RAG works
1 **Retrieve** relevant information from documents, databases, websites, policies, or internal company systems 
2 **Augment** the prompt or context window with that retrieved information 
3 **Generate** an answer using both the model’s general knowledge and the supplied evidence 

### Why RAG matters
| Problem | RAG benefit |
|---|---|
| Knowledge cutoff | Gives access to more current information  |
| Enterprise data | Lets the model use internal company documents  |
| Hallucinations | Makes invented answers less likely because the model is supplied with evidence  |

