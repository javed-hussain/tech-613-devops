# Mongo DB

## What is Mongo DB:
- NoSQL document database: stored data as flexible json-like documents rather than rows and columns in SQL tables
- Useful for data that is object like, nested or frequently changing such as prifles or games settings

### Documents:
- Basic unit of data in MongoDB - similar tp js objects / JSON objects
- stored documents as BSON (binary JSON) - supports more data types
- when a document is created - if an _id feild is not provided mongoDB automatically creates an ObjectID for the _id field - must be unique

### Collections:
- group of related documents (like a SQL table but more flexible)
- If collection doesnt exist. - MongoDB will automatically create it when the first document is inserted
- NO fixed schema: documents do not need the same fields - MongoDB uses a flexible schema - can use schema validation or mongoose validation in node.js

#### Enforcing required fields
- use sceham validation
```javascript
db.createCollection("students", {
  validator: {
    $jsonSchema: {
      required: ["name", "email"],
      properties: {
        name: { bsonType: "string" },
        email: { bsonType: "string" }
      }
    }
  }
})

// mongoose
const studentSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true },
  age: Number
});
```

### Crud Operations
One = first matching document only

Many = every matching document

|Operation|Purpose|MongoDB method|
|------|------|-------|
|Create|add documents|insertOne(), insertMany([array])|
|Read|Find documents|find(), findOne()|
|Update|Modify Documents|updateOne(), updateMany()|
|Delete|remove documents|deleteOne(), deleteMany()|

Examples

```javascript
db.students.insertOne({
  name: "Alice",
  age: 20
})

db.students.find()// returns all
db.students.find({ name: "Alice" })
db.students.findOne({ age: 20 })//first matching doc only
//MongoDB queries use JSON-like conditions $gte means >= $eq is equal to ne != lt is <
db.students.find({ age: { $gte: 18 } })

db.students.updateOne( //first matching doc
  { name: "Alice" },// filter
  { $set: { age: 21 } } //sets
)

db.students.deleteOne({ name: "Alice" })

```

### Relationships
- 2 main ways to model relationships - embedded documents or refrences
- Embedded Documents: store related data inside the same document
- Refrences: Store the ID from another collection
```javascript
//embedded
  {
  name: "Alice",
  address: {
    city: "London",
    postcode: "SW1A 1AA"
  }
}

//refrence
{
  name: "Alice",
  courseId: ObjectId("...")
}
```

### Indexing
- An index helps MongoDB find documents faster. Without an index, MongoDB may have to scan every document in a collection to answer a query. With a suitable index, it can jump directly to the relevant documents.
- db.students.createIndex({ email: 1 })
db.students.find({ email: "alice@example.com" }) , 1 = ascending order, -1 descending
- indexing = faster qureying and sorting but extra storage needed and insert updates deletes muts also update indexes
- dropIndex() to remove and index

Aggregation:
- Aggregation is MongoDB’s way of processing documents through multiple stages to filter, transform, group, sort, and calculate results. like a data processing pipeline

```javascript
db.collection.aggregate([
  { stage1 },
  { stage2 },
  { stage3 }
])
// common stages include $match, $group $sort
```