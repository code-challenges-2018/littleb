# Littleb

### Requirements

The app is built with Ruby 2.3.7 and Rails 5.2.1. It uses Postgres and GraphQL.

Note that there is a presumption that postgres is running on your machine and is accessible to your system user without password (see config/database.yml otherwise).

### Set Up

```
$ cd littleb
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed # will populate the default 'bits' list
$ rails s
```

The application is then available via GraphiQL interface at http://localhost:3000/graphiql

The app is also deployed on Heroku, but GraphiQL is not available there (see curl references in query notes below).

### Run Tests

```
$ rails test
```

### General Notes

I have chosen to implement this API exercise using GraphQL.

As a result I didn't get as far as I would have liked. In particular, bits and materials are passed as lists of names (comma-separated string) because I couldn't get an Array type working as expected.

The following functions have been implemented:

- query: bits
- query: materials
- query: users
- query: inventions
- mutation: createMaterial (name[string])
- mutation: createUser (username[string], email[string])
- mutation: createInvention (title[string], description[string], list of bits and materials as comma-separated string, and user id)
- mutation: updateInvention (see above)
- mutation: deleteInvention (id[int])

Presently, the queries return all objects of the given type (no filtering).

### Examples

Note that GraphiQL will work locally, but not on Heroku, so I've included the curl commands to use with Heroku.

All of these are just examples. You can construct the queries and mutations as you like, given the confines of the GraphQL types.

Get a list of bits:

```GraphQL
query{
  bits{
    id
    name
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"{  bits{  id name } }"}'
```

Get a list of materials:

```GraphQL
query{
  materials{
    id
    name
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"{  materials{  id name } }"}'
```

Add a material:

```GraphQL
mutation{
  createMaterial(name: "stuff-and-stuff"){
    id
    name
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"mutation{ createMaterial(name: \"scissors\"){  id name } }"}'
```

Add a user:

```GraphQL
mutation{
  createUser(username: "foobar", email: "foo@bar.com"){
    id
    username
    email
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"mutation{ createUser(username: \"edward\", email: \"edward@scissorhands.com\"){  id username email } }"}'
```

Get users:

```GraphQL
query{
  users{
    id
    username
    email
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"{  users{  id username email } }"}'
```

Add an invention (requires at least one bit):

```GraphQL
mutation{
  createInvention(
    title: "Whacky One",
    description: "Really whacky thing that I made!",
    bits_list: "bargraph, timeout",
    materials_list: "stuff-and-stuff",
    user_id: 1,
    ){
    id
    title
    description
    bits{
      name
    }
    materials{
      name
    }
    user{
      username
    }
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"mutation{ createInvention(title: \"My Great Invention\", description: \"This is my greatest invention!\", bits_list: \"bargraph, timeout\"){  id title description bits{ name } } }"}'
```

Get inventions (note users can list inventions per user):

```GraphQL
query{
  inventions{
    id
    title
    description
    bits{
      name
    }
    materials{
      name
    }
    user{
      username
      inventions{
        title
      }
    }
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"{  inventions{ id title description user{ username } materials{ name } bits{  name } } }"}'
```

Update an invention:

```GraphQL
mutation{
  updateInvention(
    id: 1,
    title: "Updated Title",
    description: "Updated Description",
    bits_list: "timeout",
    materials_list: "stuff-and-stuff",
    user_id: 1,
    ){
    id
    title
    description
    bits{
      name
    }
    materials{
      name
    }
    user{
      username
    }
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"mutation{ updateInvention(id: 1, title: \"My New Title\", description: \"My new description\", bits_list: \"timeout\"){  id title description bits{ name } } }"}'
```

Delete an invention:

```GraphQL
mutation{
  deleteInvention(
    id: 1,
  ){
    id
    title
  }
}
```

```
$ curl 'https://young-depths-78204.herokuapp.com/graphql' -H 'Content-Type: application/json'  -d '{"query":"mutation{ deleteInvention(id: 1){  id title description bits{ name } } }"}'
```
