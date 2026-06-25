# YTS API Documentation Explained

## Common Response Structure

``` json
{
  "status":"ok",
  "status_message":"Query was successful",
  "data":{ }
}
```

-   **status**: `ok` or `error`
-   **status_message**: Success/error description.
-   **data**: Payload returned by the endpoint.

------------------------------------------------------------------------

# 1. List Movies

**GET** `/list_movies.json`

**Responsibility** Retrieve a paginated list of movies with support for
searching, filtering, and sorting.

**Common Parameters** - `page` - `limit` - `genre` - `quality` -
`minimum_rating` - `query_term` - `sort_by` - `order_by`

**Returns** - `movie_count` - `limit` - `page_number` - `movies[]`

Each movie typically contains: - id - title - year - rating - runtime -
genres - summary - description_full - language - background_image -
medium_cover_image - large_cover_image - torrents\[\]

**Used For** - Home page - Browse - Search - Categories

------------------------------------------------------------------------

# 2. Movie Details

**GET** `/movie_details.json`

**Responsibility** Returns complete information about one movie.

**Parameters** - movie_id (required) - with_images - with_cast

**Returns** Movie object including: - id - title - year - rating -
runtime - description_full - genres - language - yt_trailer_code -
images - cast\[\] - torrents\[\]

**Used For** Movie Details screen.

------------------------------------------------------------------------

# 3. Movie Suggestions

**GET** `/movie_suggestions.json`

**Responsibility** Returns 4 related movies.

**Returns** - movies\[\]

**Used For** "You may also like".

------------------------------------------------------------------------

# 4. Movie Comments

**GET** `/movie_comments.json`

**Responsibility** Returns all comments for a movie.

**Returns** comments\[\] containing: - comment_id - username -
comment_text - date_added - like_count

------------------------------------------------------------------------

# 5. Movie Reviews

**GET** `/movie_reviews.json`

**Responsibility** Returns IMDb reviews.

**Returns** reviews\[\] including: - author - title - review_text -
rating

------------------------------------------------------------------------

# 6. Movie Parental Guides

**GET** `/movie_parental_guides.json`

**Responsibility** Returns parental guidance information.

**Returns** Ratings/descriptions for: - Violence - Profanity - Nudity -
Drugs - Alcohol - Frightening scenes

------------------------------------------------------------------------

# 7. List Upcoming

**GET** `/list_upcoming.json`

**Responsibility** Returns the latest upcoming movies.

**Returns** - movies\[\] (typically 4)

------------------------------------------------------------------------

# 8. User Details

**GET** `/user_details.json`

Returns public profile information and optionally recent downloads.

------------------------------------------------------------------------

# 9. Get User Key (Login)

**POST** `/user_get_key.json`

Authenticates a user.

**Returns** - user_key

------------------------------------------------------------------------

# 10. User Profile

**GET** `/user_profile.json`

Returns the authenticated user's full profile.

------------------------------------------------------------------------

# 11. Edit User Settings

**POST** `/user_edit_settings.json`

Updates password, avatar, or about text.

Returns: - status - status_message

------------------------------------------------------------------------

# 12. Register User

**POST** `/user_register.json`

Creates a new account.

Returns: - status - status_message

------------------------------------------------------------------------

# 13. Forgot Password

**POST** `/user_forgot_password.json`

Sends a password reset code.

------------------------------------------------------------------------

# 14. Reset Password

**POST** `/user_reset_password.json`

Resets the password.

------------------------------------------------------------------------

# 15. Like Movie

**POST** `/like_movie.json`

Likes a movie.

Returns: - status - status_message

------------------------------------------------------------------------

# 16. Get Movie Bookmarks

**GET** `/get_movie_bookmarks.json`

Returns the authenticated user's bookmarked movies.

------------------------------------------------------------------------

# 17. Add Movie Bookmark

**POST** `/add_movie_bookmark.json`

Adds a bookmark.

------------------------------------------------------------------------

# 18. Delete Movie Bookmark

**POST** `/delete_movie_bookmark.json`

Removes a bookmark.

------------------------------------------------------------------------

# 19. Make Comment

**POST** `/make_comment.json`

Posts a comment.

------------------------------------------------------------------------

# 20. Like Comment

**POST** `/like_comment.json`

Likes a comment.

------------------------------------------------------------------------

# 21. Report Comment

**POST** `/report_comment.json`

Reports a comment.

------------------------------------------------------------------------

# 22. Delete Comment

**POST** `/delete_comment.json`

Deletes one of the user's comments.

------------------------------------------------------------------------

# 23. Make Request

**POST** `/make_request.json`

Requests a movie to be added to YTS.

------------------------------------------------------------------------

# Recommended APIs for a Movie App

  Feature        API
  -------------- ------------------------------
  Home           GET /list_movies
  Search         GET /list_movies?query_term=
  Browse         GET /list_movies?genre=
  Details        GET /movie_details
  Suggestions    GET /movie_suggestions
  Comments       GET /movie_comments
  Reviews        GET /movie_reviews
  Upcoming       GET /list_upcoming
  Login          POST /user_get_key
  Register       POST /user_register
  Watchlist      Bookmark APIs
  Like Movie     POST /like_movie
  Post Comment   POST /make_comment
