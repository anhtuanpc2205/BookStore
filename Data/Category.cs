using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class Category
{
    public int CategoryId { get; set; }

    public string CategoryName { get; set; } = null!;

    public virtual ICollection<BookSCategoryAndGenre> BookSCategoryAndGenres { get; set; } = new List<BookSCategoryAndGenre>();
}
