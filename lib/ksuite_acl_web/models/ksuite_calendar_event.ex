defmodule KSuiteACLWeb.Models.KsuiteCalendarEvent do
  use TypedStruct

  @derive Jason.Encoder

  typedstruct do
    @typedoc "A Kalendar Event"

    field(:subject, String.t(), enforce: true)
    field(:from, String.t(), enforce: true)
    field(:to, String.t(), enforce: true)
    field(:description, String.t(), enforce: true)
  end
end
