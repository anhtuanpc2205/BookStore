using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class BookDetail
{
    public int BookDetailId { get; set; }

    public int BookId { get; set; }

    public string? Isbn10 { get; set; }

    public string? Isbn13 { get; set; }

    public int FormatId { get; set; }

    public int StockQuantity { get; set; }

    public int? Views { get; set; }

    public decimal Price { get; set; }

    public decimal? Discount { get; set; }

    public virtual Book Book { get; set; } = null!;

    public virtual Format Format { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual ICollection<UserWishlist> UserWishlists { get; set; } = new List<UserWishlist>();
}
