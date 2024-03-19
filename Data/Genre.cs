using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class Genre
{
    public int GenreId { get; set; }

    public string GenreName { get; set; } = null!;

    public virtual ICollection<BookSCategoryAndGenre> BookSCategoryAndGenres { get; set; } = new List<BookSCategoryAndGenre>();
}
