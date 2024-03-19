using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class BookSCategoryAndGenre
{
    public int CategoryId { get; set; }

    public int GenreId { get; set; }

    public int BookId { get; set; }

    public virtual Book Book { get; set; } = null!;

    public virtual Category Category { get; set; } = null!;

    public virtual Genre Genre { get; set; } = null!;
}
