using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class Book
{
    public int BookId { get; set; }

    public string Title { get; set; } = null!;

    public int AuthorId { get; set; }

    public string? ImageUrl { get; set; }

    public string? Description { get; set; }

    public string? Publisher { get; set; }

    public string? Language { get; set; }

    public string? IllustrationsNote { get; set; }

    public int? Pages { get; set; }

    public virtual Author Author { get; set; } = null!;

    public virtual ICollection<BookDetail> BookDetails { get; set; } = new List<BookDetail>();

    public virtual ICollection<BookSCategoryAndGenre> BookSCategoryAndGenres { get; set; } = new List<BookSCategoryAndGenre>();
}
