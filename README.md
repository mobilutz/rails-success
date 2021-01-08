# README

This app shows an error that can be traces back solely to an upgrade of Rails von v5 to v6.

The problem is, that the following statement works on Rails 5 but not in Rails 6.
```
Post.select(Post::SELECTS).order(Post::ORDER).includes(:user).references(:user).joins(:post_tags)
```

## How to reproduce

1. clone this repo
1. run migration
1. run the following script:
```
Tag.create(name: 'T1')
Tag.create(name: 'T2')

user = User.create(name: 'Name')
post = Post.create(title: 'Title', order: 1, user: user)
post.tags = Tag.all
```

After this, the command from above fails on Rails6 but succeeds on Rails5.
```
Post.select(Post::SELECTS).order(Post::ORDER).includes(:user).references(:user).joins(:post_tags)
```

I traced it down to a combination of the selects `Post::SELECTS` and the `joins(:post_tags)`.

The following things also work on Rails6 without problem:
* `Post.select(Post::SELECTS).order(Post::ORDER).joins(:user).references(:user).joins(:post_tags)`
* `Post.select(Post::SELECTS).order(Post::ORDER).joins(:user).references(:user)`
* `Post.select(Post::SELECTS).order(Post::ORDER).includes(:user).references(:user)`
* `Post.includes(:user).references(:user).joins(:post_tags)`

I hope that this is information enough, if not please feel free to contact me.