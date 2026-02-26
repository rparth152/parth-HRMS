<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EventsCalender.aspx.cs" Inherits="parth_HRMS.EventsCalender" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Events Calendar</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>

<style>
    body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    .card { border: none; box-shadow: 0 0 15px rgba(0,0,0,0.05); border-radius: 8px; }
    .btn-orange { background-color: #f37021; color: white; border: none; font-weight: 600; }
    .btn-orange:hover { background-color: #d65c17; color: white; }
    
    /* Event Card Styling */
    .event-card { border: 1px solid #e9ecef; border-radius: 6px; padding: 15px; margin-bottom: 15px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
    .event-title { font-weight: bold; color: #2c3e50; font-size: 1.1rem; }
    .event-date { color: #17a2b8; font-weight: 600; margin-top: 5px; } /* Teal color as in screenshot */
    
    /* Calendar UI Adjustments */
    #calendar { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.05); }
    .fc-toolbar-title { font-weight: bold !important; color: #2c3e50; }
    .fc-button-primary { background-color: #343a40 !important; border-color: #343a40 !important; }
    .fc-button-active { background-color: #f37021 !important; border-color: #f37021 !important; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-4">
    <div class="row">
        <div class="col-md-8">
            <div id="calendar"></div>
        </div>

        <div class="col-md-4">
            <button type="button" class="btn btn-orange w-100 py-3 mb-4" data-bs-toggle="modal" data-bs-target="#addEventModal" onclick="clearModal();">
                Add New Event
            </button>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Repeater ID="rptUpcomingEvents" runat="server">
                        <ItemTemplate>
                            <div class="event-card">
                                <div class="event-title"><%# Eval("Title") %></div>
                                <div class="event-date"><%# Eval("Date") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</div>

<asp:UpdatePanel ID="UpdatePanelModal" runat="server">
    <ContentTemplate>
        <div class="modal fade" id="addEventModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title fw-bold" id="modalTitle">Add New Event</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <div class="mb-3">
                      <label class="form-label text-muted">Event Title</label>
                      <asp:TextBox ID="txtEventTitle" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                      <label class="form-label text-muted">Event Date</label>
                      <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                      <label class="form-label text-muted">Event Type</label>
                      <asp:DropDownList ID="ddlEventType" runat="server" CssClass="form-select"></asp:DropDownList>
                  </div>
              </div>
              <div class="modal-footer justify-content-start">
                <asp:Button ID="btnSubmitEvent" runat="server" Text="Add Event" CssClass="btn btn-orange" OnClick="btnSubmitEvent_Click" />
              </div>
            </div>
          </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">
    // Initialize Calendar
    document.addEventListener('DOMContentLoaded', function () {
        initCalendar();
    });

    function initCalendar() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: function(info, successCallback, failureCallback) {
                // Call C# WebMethod via AJAX (PageMethods)
                PageMethods.GetCalendarEvents(function (response) {
                    var events = JSON.parse(response);
                    successCallback(events);
                }, function (error) {
                    console.log("Error fetching events:", error);
                });
            }
        });
        calendar.render();
    }

    // Function to re-fetch calendar events from C# code-behind after adding new event
    function refreshCalendar() {
        initCalendar();
    }

    function clearModal() {
        document.getElementById('<%= txtEventTitle.ClientID %>').value = '';
        document.getElementById('<%= txtEventDate.ClientID %>').value = '';
        document.getElementById('<%= ddlEventType.ClientID %>').selectedIndex = 0;
    }
</script>
</asp:Content>
