using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class UserWishlist
{
    public int WishlistId { get; set; }

    public int UserId { get; set; }

    public int BookDetailId { get; set; }

    public virtual BookDetail BookDetail { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
