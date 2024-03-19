using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Data;

public partial class BookStoreContext : DbContext
{
    public BookStoreContext()
    {
    }

    public BookStoreContext(DbContextOptions<BookStoreContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Author> Authors { get; set; }

    public virtual DbSet<Blog> Blogs { get; set; }

    public virtual DbSet<Book> Books { get; set; }

    public virtual DbSet<BookDetail> BookDetails { get; set; }

    public virtual DbSet<BookSCategoryAndGenre> BookSCategoryAndGenres { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Format> Formats { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserWishlist> UserWishlists { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=BookStore;Integrated Security=True;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Author>(entity =>
        {
            entity.HasKey(e => e.AuthorId).HasName("PK__Author__86516BCF4773F76C");

            entity.ToTable("Author");

            entity.Property(e => e.AuthorId).HasColumnName("author_id");
            entity.Property(e => e.AuthorName)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("author_name");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description_");
            entity.Property(e => e.ProfileImageUrl)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("profile_image_url");
        });

        modelBuilder.Entity<Blog>(entity =>
        {
            entity.HasKey(e => e.BlogId).HasName("PK__Blog__2975AA28607BEFD8");

            entity.ToTable("Blog");

            entity.Property(e => e.BlogId).HasColumnName("blog_id");
            entity.Property(e => e.AuthorId).HasColumnName("author_id");
            entity.Property(e => e.BlogTitle)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("blog_title");
            entity.Property(e => e.Content)
                .HasColumnType("text")
                .HasColumnName("content_");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description_");

            entity.HasOne(d => d.Author).WithMany(p => p.Blogs)
                .HasForeignKey(d => d.AuthorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_Blog_author_id");
        });

        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(e => e.BookId).HasName("PK__Book__490D1AE1F552E9CF");

            entity.ToTable("Book");

            entity.Property(e => e.BookId).HasColumnName("book_id");
            entity.Property(e => e.AuthorId).HasColumnName("author_id");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description_");
            entity.Property(e => e.IllustrationsNote)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("Illustrations_note");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("image_url");
            entity.Property(e => e.Language)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("language_");
            entity.Property(e => e.Publisher)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("title");

            entity.HasOne(d => d.Author).WithMany(p => p.Books)
                .HasForeignKey(d => d.AuthorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_author_id");
        });

        modelBuilder.Entity<BookDetail>(entity =>
        {
            entity.HasKey(e => e.BookDetailId).HasName("PK__Book_Det__8278ABD5803EA7D4");

            entity.ToTable("Book_Detail");

            entity.Property(e => e.BookDetailId).HasColumnName("Book_Detail_id");
            entity.Property(e => e.BookId).HasColumnName("book_id");
            entity.Property(e => e.Discount)
                .HasDefaultValue(0m)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("discount");
            entity.Property(e => e.FormatId).HasColumnName("format_id");
            entity.Property(e => e.Isbn10)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("ISBN10");
            entity.Property(e => e.Isbn13)
                .HasMaxLength(13)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("ISBN13");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("price");
            entity.Property(e => e.StockQuantity).HasColumnName("stock_quantity");
            entity.Property(e => e.Views)
                .HasDefaultValue(0)
                .HasColumnName("views_");

            entity.HasOne(d => d.Book).WithMany(p => p.BookDetails)
                .HasForeignKey(d => d.BookId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_bookDetail");

            entity.HasOne(d => d.Format).WithMany(p => p.BookDetails)
                .HasForeignKey(d => d.FormatId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_bookDetail_Format_");
        });

        modelBuilder.Entity<BookSCategoryAndGenre>(entity =>
        {
            entity.HasKey(e => new { e.CategoryId, e.GenreId, e.BookId }).HasName("PK__Book_s_C__0483CC7A8388A282");

            entity.ToTable("Book_s_Category_And_Genre");

            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.GenreId).HasColumnName("genre_id");
            entity.Property(e => e.BookId).HasColumnName("book_id");

            entity.HasOne(d => d.Book).WithMany(p => p.BookSCategoryAndGenres)
                .HasForeignKey(d => d.BookId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_Book_s_Category_And_Genre_book_id");

            entity.HasOne(d => d.Category).WithMany(p => p.BookSCategoryAndGenres)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_Book_s_Category_And_Genre_CategoryId");

            entity.HasOne(d => d.Genre).WithMany(p => p.BookSCategoryAndGenres)
                .HasForeignKey(d => d.GenreId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_Book_s_Category_And_Genre_Genre_id");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.CategoryId).HasName("PK__Category__D54EE9B4F289CB54");

            entity.ToTable("Category");

            entity.Property(e => e.CategoryId).HasColumnName("category_id");
            entity.Property(e => e.CategoryName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("category_name");
        });

        modelBuilder.Entity<Format>(entity =>
        {
            entity.HasKey(e => e.FormatId).HasName("PK__Format___26B11DF1A8A85D50");

            entity.ToTable("Format_");

            entity.Property(e => e.FormatId).HasColumnName("format_id");
            entity.Property(e => e.FormatName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("format_name");
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(e => e.GenreId).HasName("PK__Genre__18428D42EF810B7C");

            entity.ToTable("Genre");

            entity.Property(e => e.GenreId).HasColumnName("genre_id");
            entity.Property(e => e.GenreName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("genre_name");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Order___46596229A8F0F68D");

            entity.ToTable("Order_");

            entity.Property(e => e.OrderId).HasColumnName("order_id");
            entity.Property(e => e.OrderDate).HasColumnName("order_date");
            entity.Property(e => e.OrderStatus)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("order_status");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("payment_method");
            entity.Property(e => e.ShippingFee)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("shipping_fee");
            entity.Property(e => e.ShippingMethod)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("shipping_method");
            entity.Property(e => e.TotalAmount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("total_amount");
            entity.Property(e => e.UserId).HasColumnName("user_id_");

            entity.HasOne(d => d.User).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("user_id_");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.OrderDetailId).HasName("PK__Order_De__3C5A4080905AA051");

            entity.ToTable("Order_Detail");

            entity.Property(e => e.OrderDetailId).HasColumnName("order_detail_id");
            entity.Property(e => e.BookDetailId).HasColumnName("Book_Detail_id");
            entity.Property(e => e.OrderId).HasColumnName("order_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.BookDetail).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.BookDetailId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_orderDetail_Book_Detail_id");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_orderDetail_id");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__User___EE50E8ED22F23A6B");

            entity.ToTable("User_");

            entity.Property(e => e.UserId).HasColumnName("user_id_");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.Password)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("password_");
            entity.Property(e => e.ProfileImageUrl)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("profile_image_url");
            entity.Property(e => e.Role).HasColumnName("role_");
            entity.Property(e => e.ShippingAddress)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("shipping_address");
            entity.Property(e => e.UserName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_name_");
        });

        modelBuilder.Entity<UserWishlist>(entity =>
        {
            entity.HasKey(e => e.WishlistId).HasName("PK__User_wis__6151514EF08E052E");

            entity.ToTable("User_wishlist");

            entity.Property(e => e.WishlistId).HasColumnName("wishlist_id");
            entity.Property(e => e.BookDetailId).HasColumnName("Book_Detail_id");
            entity.Property(e => e.UserId).HasColumnName("user_id_");

            entity.HasOne(d => d.BookDetail).WithMany(p => p.UserWishlists)
                .HasForeignKey(d => d.BookDetailId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_user_wishlist_Book_Detail");

            entity.HasOne(d => d.User).WithMany(p => p.UserWishlists)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_user_wishlist_user_id");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
