using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class Blog
{
    public int BlogId { get; set; }

    public string BlogTitle { get; set; } = null!;

    public string? Description { get; set; }

    public string? Content { get; set; }

    public int AuthorId { get; set; }

    public virtual Author Author { get; set; } = null!;
}
