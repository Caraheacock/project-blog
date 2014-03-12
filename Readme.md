# Requirements

- User info (possibly multiple users, but I’m not sure if this is an individual’s blog site or a blog site for multiple people to sign up), which will have:
  - Username
  - Password
  - First name
  - Last name
  - Email address? (for recovering lost passwords maybe; I can’t think of anything else my super basic blog site would want it for)
  - Social media links (Facebook, Twitter, etc.)
- Profile page, displaying the user info and maybe previews of blog posts
- Blog posts, which will have:
  - Title
  - Date posted (user cannot set this)
  - Blog content
  - Pictures?
- Comments, which will have:
  - Commenter name
  - Comment post date
  - Comment content

---

# Plan

- Create a database with tables for all that stuff in the requirements
- Write tests, I guess ):
- Write the back-end Ruby that allows for updating the database
- Write the front-end pages where the blog is displayed

###I think I have an idea, but feel a little sketchy on:
- Having the user sign in and out
- Denying certain permissions to someone who is not the appropriate user

###I have no idea how to:
- Store pictures. Can pictures even go in a database? Will they have to be uploaded elsewhere and we just store the URL?
- Delete things out of the database that were just tests. So far we’ve only learned how to add things. It would be nice when running tests if the test could auto-delete what it inputted after it’s done.