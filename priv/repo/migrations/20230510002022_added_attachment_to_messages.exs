defmodule StreamChat.Repo.Migrations.AddedAttachmentToMessages do
  use Ecto.Migration

  def change do

    alter table(:messages) do
      add :attachment, :string
    end

  end
end
