-- Split seed data files generated from original 100_seed_data.sql.
-- Execute files in filename order. Each file preserves original table-block order.
SET LOCAL search_path = {schema}, pg_catalog;

-- Seed: a__naeventimg (0 rows)
-- No rows in source dump for a__naeventimg.

-- Seed: ad_prhistory (0 rows)
-- No rows in source dump for ad_prhistory.

-- Seed: astcpattach (0 rows)
-- No rows in source dump for astcpattach.

-- Seed: ax_homebuild_master (0 rows)
-- No rows in source dump for ax_homebuild_master.

-- Seed: ax_homebuild_responsibility (0 rows)
-- No rows in source dump for ax_homebuild_responsibility.

-- Seed: ax_homebuild_saved (0 rows)
-- No rows in source dump for ax_homebuild_saved.

-- Seed: ax_homebuild_sd_responsibility (0 rows)
-- No rows in source dump for ax_homebuild_sd_responsibility.

-- Seed: ax_hp_user_level_widget (0 rows)
-- No rows in source dump for ax_hp_user_level_widget.

-- Seed: ax_htmlplugins (7 rows)
INSERT INTO {schema}.ax_htmlplugins (name, htmltext, context)
VALUES
('Menu icons', '<div data-shadowdom="false" class="dasboard-cards">
  <div class="card">
    <div class="card-header">
      <h4 class="card-title mb-4">{{cardname}}</h4>

    </div>
    <div class="card-body">
      <div class="Empty-card-msg d-none">
        <img class="img-fluid" alt="Card image" src="https://cdn-icons-png.flaticon.com/128/17426/17426064.png">
        <p>Your menu links will be listed in this space.</p>
      </div>
      <div class="placeholder-content">
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
      </div>
      <div class="HomePageMenuOptionCards_{{axp_cardsid}} HomePageMenuOptionCards mb-8 col-md-12"></div>
    </div>
  </div>
<style>
/* Outer card container */
/*
.menu-card {
  background: #fff; 
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
  padding: 16px;
  text-align: center;
  transition: transform 0.2s ease-in-out;
  cursor: pointer;
}
.menu-card:hover {  transform: translateY(-3px);}

.menu-card-icon {
  background-color: #fef8f5; 
  border-radius: 8px;
  padding: 12px;
  margin-bottom: 10px;
}

.menu-card-icon img {
  height: auto;}

.menu-card-title {
  font-weight: 600;
  font-size: 1rem;
  margin-top: 8px;
}
*/

  </style>

  <script>
    setTimeout(function () {
      //Enable this code once you have datasource ready.
      //columns needed from datasource ->title,subtitle,time,link,image

      var dsObj = new EntityCommon();
      var data = dsObj.getCardData(`{{cardname}}`);

      if (data && data.length == 0) {
        $(".HomePageMenuOptionCards_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none");
        $(".HomePageMenuOptionCards_{{axp_cardsid}}").addClass("d-none");
        $(".HomePageMenuOptionCards_{{axp_cardsid}}").parent().find(".Empty-card-msg").removeClass("d-none");
      }
      else {
        let generatedMenuOptionHTML = '''';
        data.forEach((rowData, index) => {
          const moreOption = rowData.moreoption;
          var stransid = rowData.stransid;
          const rowCount = index;
          rowData.rowCount = rowCount;

generatedMenuOptionHTML +=
  `<div class="mt-3 widgetWrapper htmlDomWrapper col-lg-4 col-md-4 col-sm-4 Home-cards-list" data-cardname="${rowData.name}">
      <div class="menu-card " onclick="navigateToUrl(''${rowData.link}'')">
          <div class="menu-card-icon Hp-card-icon">
              <img class="img-fluid w-60px cardsIcons" src="../images/homepageicon/${rowData.name}.png"
                   onerror="this.onerror=null;this.src=''../images/homepageicon/default.png'';">
          </div>
          <div class="menu-card-title Hp-card-title text-truncate" title="${rowData.name}">
            ${rowData.name}
          </div>
      </div>
  </div>`;



        });

        if (generatedMenuOptionHTML != '''') {
          let divOpen = `<div class=""><div class=""><div class="row d-flex">` + generatedMenuOptionHTML + `</div></div></div>`;
          const tabContainer = document.querySelector(`.HomePageMenuOptionCards_{{axp_cardsid}}`);
          tabContainer.innerHTML = divOpen;
          $(".HomePageMenuOptionCards_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none")
        } else {
          const tabContainer = document.querySelector(`.HomePageMenuOptionCards_{{axp_cardsid}}`);
          tabContainer.classList.add("d-none");
          $(".HomePageMenuOptionCards_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none")
        }

      }
    }, 1);

  </script>
</div>', 'cards'),
('KPI Icons', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card KPI-dashcards">
        <div class="card-header pb-0">
            <h4 class="card-title mb-4">Cards</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class=" " onclick="LoadIframe(''processflow.aspx?dashboard=t'');">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
                <a href="#" data-bs-toggle="tooltip" class=" d-none" >
                    <span class="material-icons material-icons-style material-icons-2">
                        fullscreen
                    </span>
                </a>
            </div>

        </div>
        <div class="card-body">
          <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
            <div class="row" id="KPI_Sales">
            </div>
        </div>
    </div>

    <script>
      setTimeout(function () {
      	  	var dsObj = new EntityCommon();
            var data = dsObj.getCardData(`{{cardname}}`)


                let generatedMenuOptionHTML = '''';
                data.forEach((rowData, index) => {
                    const moreOption = rowData.moreoption;
                    var stransid = rowData.stransid;
                    const rowCount = index;
                    rowData.rowCount = rowCount;

                    generatedMenuOptionHTML +=
                        `<div class=" widgetWrapper kpiWrapper " card-index="0">
                        <div class="card rounded-1 shadow-sm h-100 cardbg-${(index % 6) + 1}">
                            <!--begin::Card content wrapper-->
                            <div class="card-content-wrapper d-flex align-items-center">
                                <div class="card-title d-flex ">

                                    <div class="d-none mainIcon w-100--- me-2">
                                        <img alt="Icon" src="" class="mh-35px mw-35px">
                                    </div>

                                    <div class="symbol symbol-35px me-2 mainIcon">
                                        <div class="symbol-label cardbg-inverse-${(index % 6) + 1}">
                                            <div class="Invoice-icon" style="display: flex;">
                                                <span class="material-icons material-icons-style material-icons-2">bar_chart</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="Kpi-content">
                                        <span class="Kpi-caption mainHeading">${rowData.name}</span>
                                        <a href="#" onclick="navigateToUrl(''${rowData.link}'')">${rowData.value}</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Card Toolbar -->
                            <div class="card-toolbar d-flex justify-content-end d-none">
                                <a href="javascript:void(0);" class="btn btn-sm btn-flex btn-light-primary cardbg-3">
                                    <statuscontent></statuscontent>
                                </a>
                            </div>

                            <!-- Card Footer -->
                            <div class="card-footer border-0 d-none">
                                <div class="fs-7 fw-normal text-muted">
                                    <footercontent></footercontent>
                                </div>
                            </div>
                        </div>
                    </div>`;
                });

                document.querySelector(`#KPI_Sales`).innerHTML = generatedMenuOptionHTML;
                $("#KPI_Sales").parent().find(".placeholder-content").addClass("d-none")


        }, 1)

    </script>
</div>', 'cards'),
('Task list', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card active-list-wrapper">
        <div class="card-header pb-0">
            <h4 class="card-title mb-4">Active List</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class=" " onclick="LoadIframe(''processflow.aspx?activelist=t'');">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
            </div>

        </div>
        <div class="card-body" id="ActiveListcardbody">
      <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
      </div>
    </div>
    <script>
        setTimeout(function () {
          var dsObj = new EntityCommon();
          var data = dsObj.getCardData(`{{cardname}}`);

          function getMaterialIconName(task) {
            const taskIcons = {
              "task-peg": "account_tree",
              "task-make": "task",
              "task-made": "task",
              "task-approval": "fact_check",
              "task-checked": "fact_check",
              "task-approved": "task_alt",
              "task-rejected": "scan_delete",
              "task-returned": "source_notes",
              "task-sent": "share_windows",
              "task-escalation": "problem",
              "task-reminder": "notifications_active",
              "task-msg": "chat",
              "task-excel export": "file_export",
              "task-formnotification": "assignment_late"
            };

            return taskIcons[task] || "task";
          }

          function constructTaskStatusString(data) {
            const parts = [];

            if (data.taskstatus) {
              parts.push(`task-${data.taskstatus}`);
            } else if (data.tasktype) {
              parts.push(`task-${data.tasktype}`);
            }

            return parts.join("")?.replaceAll(" ", "").toLowerCase() || "";
          }

          function constructTaskTypeString(data) {
            const parts = [];

            if (data.msgtype && data.msgtype.toLowerCase() != "na") {
              parts.push(`task-msg`);
            } else if (data.rectype) {
              parts.push(`task-${data.rectype}`);
            }

            return parts.join("")?.replaceAll(" ", "").toLowerCase() || "";
          }
          const renderTimeFormat = (datetime) => {
            const now = new Date();
            const eventDate = new Date(datetime.replace(/(\d+)\/(\d+)\/(\d+)/, ''$2/$1/$3'')); // Parse DD/MM/YYYY
            const diffTime = Math.abs(now - eventDate);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            if (diffDays === 0) return "Today";
            if (diffDays === 1) return "Yesterday";
            if (diffDays <= 7) return "This Week";
            if (diffDays <= 14) return "Last Week";
            if (diffDays <= 30) return "Last Month";
            return "Older";
          };

          const renderHTML = (item) => {

            const displayTitle = item.displaytitle || "-";
            const status = item.cstatus?.toLowerCase() || "";
            const displayContent = item.displaycontent || "No Content";
            const timeFormat = renderTimeFormat(item.eventdatetime);
            const firstText = displayTitle.charAt(0).toUpperCase();
            const taskClass = constructTaskStatusString(item);
            const taskTypeClass = constructTaskTypeString(item);

            var iconName = getMaterialIconName(taskClass || taskTypeClass || "") || "task";

            return `
        <div class="listrow ${status} ${taskClass} ${taskTypeClass}">
            <div class="row">
                <div class="col-2 checkbox-wrapper">
                    <div class="symbol symbol-35px symbol-circle ${status} ${taskClass} ${taskTypeClass}">
                        <span class="symbol-label bg-danger text-white fs-6 fw-bolder"><span class="material-icons material-icons-style material-icons-2">${iconName}</span></span>
      </div>
      </div>
                <div class="col-7">
                    <a href="javascript:void(0)" class="tasktitle border-bottom">${displayTitle}</a>
                    <div class="taskcontent">${displayContent}</div>
      </div>
                <div class="timespace col-3">
                    <div class="nametime">${timeFormat}</div>
      </div>
      </div>
      </div>
    `;
          };

          const container = document.querySelector("#ActiveListcardbody");
          data.forEach((item) => {
            container.innerHTML += renderHTML(item);
          });

          $("#ActiveListcardbody").parent().find(".placeholder-content").addClass("d-none")


        }, 1)

    </script>
</div>', 'cards'),
('News Card', '<div data-shadowdom="false" class="dasboard-cards">
  <div class="card">
    <div class="card-header">
      <h4 class="card-title mb-4">{{cardname}}</h4>
      <div class="card-toolbar">
        <a href="#" data-bs-toggle="tooltip" class="border-bottom" onclick="LoadIframe(''processflow.aspx?calendar=t'');">
          <span class="material-icons material-icons-style material-icons-2">
            open_in_new
          </span>
        </a>
      </div>
    </div>
    <div class="card-body">
      <div class="Empty-card-msg d-none">
        <img class="img-fluid" alt="Card image"  src="https://cdn-icons-png.flaticon.com/128/17426/17426064.png">
        <p>Interesting news/Upcoming events will be listed in this space.</p>
      </div>
      <div class="placeholder-content">
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
        <div class="placeholder-content_item"></div>
      </div>
      <div class="row eventsContainer" id="eventsContainer_{{axp_cardsid}}">
        <!-- Dynamic Events will be inserted here -->
      </div>
    </div>
  </div>

  <script>
    setTimeout(function () {
      //Enable this code once you have datasource ready.
      //columns needed from datasource ->title,subtitle,time,link,image

function htmlDecode(str) {
  const txt = document.createElement(''textarea'');
  txt.innerHTML = str;
  return txt.value;
}



      var dsObj = new EntityCommon();
var key = htmlDecode(`{{cardname}}`);
var data = dsObj.getCardData(key);

      const container = document.getElementById(''eventsContainer_{{axp_cardsid}}'');

      // Function to calculate human-readable time difference
      function timeAgo(date) {
        const now = new Date();
        const eventDate = new Date(date);
        const diffInSeconds = Math.floor((now - eventDate) / 1000);
        const minutes = Math.floor(diffInSeconds / 60);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);
        const weeks = Math.floor(days / 7);
        const months = Math.floor(days / 30);

        if (diffInSeconds < 60) return "Last updated just now";
        if (minutes < 60) return `Last updated ${minutes} min${minutes > 1 ? "s" : ""} ago`;
        if (hours < 24) return `Last updated ${hours} hour${hours > 1 ? "s" : ""} ago`;
        if (days < 7) return `Last updated ${days} day${days > 1 ? "s" : ""} ago`;
        if (weeks < 4) return `Last updated ${weeks} week${weeks > 1 ? "s" : ""} ago`;
        return `Last updated ${months} month${months > 1 ? "s" : ""} ago`;
      }
      if (data && data.length == 0) {
        $("#eventsContainer_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none");
        $("#eventsContainer_{{axp_cardsid}}").addClass("d-none");
        $("#eventsContainer_{{axp_cardsid}}").parent().find(".Empty-card-msg").removeClass("d-none");
      }
      else {

        data.forEach(event => {
          const card = document.createElement(''div'');
          card.className = ''col-lg-12 Events-items'';
          if(event?.image && typeof event.image != "undefined" && event.image != "")
            event.image = event.image.replace(''$APP_NAME$'', window.top.mainProject) + "?v=" + event.modifiedon.replaceAll(" ", "").replaceAll("T", "").replaceAll("-", "") ;
    else
            event.image = "images/NotificationIcons/Announcement.png";
          
          card.innerHTML = `
              <div class="card">
                  <div class="row no-gutters align-items-center">
                      <div class="col-md-3">
                          <img class="card-img img-fluid" height="100" width="100" alt="Card image" src="../${event.image}">
                      </div>
                      <div class="col-md-9">
                          <div class="card-body">
                              <h5 class="card-title">
                                  <a href="#" class="text-decoration-none" onclick="navigateToUrl(''${event.link}'')">${event.title}</a>
                              </h5>
                              <p class="card-text">${event.subtitle}</p>
                              <p class="card-text"><small class="text-muted">${timeAgo(event.modifiedon.replaceAll("T", " "))}</small></p>
                          </div>
                      </div>
                  </div>
              </div>
          `;

          container.appendChild(card);
        });

        $("#eventsContainer_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none");
      }
    }, 1)

  </script>
</div>', 'cards'),
('Banner card', '
<div data-shadowdom="false" class="dasboard-cards" data-card="{{cardname}}">
    <div class="card welcome-card">
        <div class="WelcomeCard-Wrapper">
            <img class="DashSliser-img" alt=""
                src="https://agileqa.agilecloud.biz/qaaxpert11.4base/CustomPages/images/slider1.png">
            <div class="carousel carousel-custom carousel-stretch slide Dashboard_Slider" data-bs-ride="carousel"
                data-bs-interval="8000"></div>
        </div>
    </div>

    <script>
    setTimeout(() => {
const cardWrapper = document.querySelector(
        `.dasboard-cards[data-card="{{cardname}}"]`
    );
      if (!cardWrapper) return;
      
 const container = cardWrapper.querySelector(".Dashboard_Slider");
       if (!container) return;
      
       // 🔑 unique ID per card
    const carouselId = `Dashboard_Slider_${Date.now()}_${Math.floor(Math.random()*1000)}`;
    container.setAttribute("id", carouselId);
      
  var dsObj = new EntityCommon();
  var data = dsObj.getCardData(`{{cardname}}`); 

  const slides = data.map((item, index) => ({
    title: item.title,
    description: `${item.subtitle} - ${item.time}`,
    isActive: index === 0 
  }));

  const carouselData = {
    carouselId: "Dashboard_Slider",
    title: "Axi Global",
    interval: 8000,
    slides: slides
  };

  

  const headingHtml = `
    <div class="d-flex flex-stack align-items-center flex-wrap">
      <h4 class="SliderHeading">${carouselData.title}</h4>
      <ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
        ${carouselData.slides
          .map(
            (slide, index) => `
              <li data-bs-target="#${carouselId}" data-bs-slide-to="${index}" class="ms-1 ${
              slide.isActive ? "active" : ""
            }" ${slide.isActive ? ''aria-current="true"'' : ""}></li>
            `
          )
          .join("")}
      </ol>
    </div>`;



  const innerHtml = `
    <div class="carousel-inner pt-6">
      ${carouselData.slides
        .map(
          (slide) => `
        <div class="carousel-item ${slide.isActive ? "active" : ""}">
          <div class="carousel-wrapper">
            <div class="d-flex flex-column flex-grow-1">
              <a href="#" class="Slider-Title border-bottom">${slide.title}</a>
              <p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">${slide.description}</p>
            </div>
            <div class="d-flex flex-stack pt-8">
              <!-- Optionally, you can add extra markup here -->
            </div>
          </div>
        </div>
      `
        )
        .join("")}
    </div>`;

    container.innerHTML = headingHtml + innerHtml;

}, 1);

    </script>
</div>', 'cards'),
('KPI List', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card KPI-dashcards">
        <div class="card-header pb-0">
            <h4 class="card-title mb-4 cardtitle_{{axp_cardsid}}">KPI</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class=" " onclick="LoadIframe(''processflow.aspx?dashboard=t'');">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
                <a href="#" data-bs-toggle="tooltip" class=" d-none" >
                    <span class="material-icons material-icons-style material-icons-2">
                        fullscreen
                    </span>
                </a>
            </div>

        </div>
        <div class="card-body">
          <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
            <div class="row" id="KPI_CardsList_Wrapper_{{axp_cardsid}}">
            </div>
        </div>
    </div>

    <script>
        setTimeout(() => {
          var dsObj = new EntityCommon();
          var data = dsObj.getCardData(`{{cardname}}`); 

      let generatedMenuOptionHTML = '''';
      data.forEach((rowData, index) => {
        const moreOption = rowData.moreoption;
        var stransid = rowData.stransid;
        const rowCount = index;
        rowData.rowCount = rowCount;

        generatedMenuOptionHTML +=
          `<div class=" widgetWrapper kpiWrapper " card-index="0">
                        <div class="card rounded-1 shadow-sm h-100 cardbg-${(index % 6) + 1}">
                            <!--begin::Card content wrapper-->
                            <div class="card-content-wrapper d-flex align-items-center">
                                <div class="card-title d-flex ">

                                    <div class="d-none mainIcon w-100--- me-2">
                                        <img alt="Icon" src="" class="mh-35px mw-35px">
      </div>

                                    <div class="symbol symbol-35px me-2 mainIcon">
                                        <div class="symbol-label cardbg-inverse-${(index % 6) + 1}">
                                            <div class="Invoice-icon" style="display: flex;">
                                                <span class="material-icons material-icons-style material-icons-2">bar_chart</span>
      </div>
      </div>
      </div>

                                    <div class="Kpi-content">
                                        <span class="Kpi-caption mainHeading">${rowData.name}</span>
                                        <a href="#" onclick="navigateToUrl(''${rowData.link}'')">${rowData.value}</a>
      </div>
      </div>
      </div>

                            <!-- Card Toolbar -->
                            <div class="card-toolbar d-flex justify-content-end d-none">
                                <a href="javascript:void(0);" class="btn btn-sm btn-flex btn-light-primary cardbg-3">
                                    <statuscontent></statuscontent>
      </a>
      </div>

                            <!-- Card Footer -->
                            <div class="card-footer border-0 d-none">
                                <div class="fs-7 fw-normal text-muted">
                                    <footercontent></footercontent>
      </div>
      </div>
      </div>
      </div>`;
      });

      document.querySelector(`#KPI_CardsList_Wrapper_{{axp_cardsid}}`).innerHTML = generatedMenuOptionHTML;
      $("#KPI_CardsList_Wrapper_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none")
		document.querySelector(".cardtitle_{{axp_cardsid}}").innerHTML = `{{cardname}}`;

        }, 1)

    </script>
</div>', 'cards'),
('Activity List', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title mb-4">{{cardname}}</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class="d-none">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="Empty-card-msg d-none">
                <img class="img-fluid" alt="Card image" src="../images/homepageicon/Emptycard.png">
                <p>No activities available.</p>
              <span> when you do , you will see them here...</span>
            </div>
            <div class="placeholder-content">
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
                <div class="placeholder-content_item"></div>
            </div>
            <ul class="verti-timeline list-unstyled activitylist" id="activitylist_{{axp_cardsid}}">
            </ul>
        </div>
    </div>

    <script>
        setTimeout(function () {
            //Enable this code once you have datasource ready.
            //columns needed from datasource ->name,value,link

            var dsObj = new EntityCommon();
            var data = dsObj.getCardData(`{{cardname}}`);

            const activityList = document.getElementById(''activitylist_{{axp_cardsid}}'');

            // Convert timestamp to a human-readable format
            function timeAgo(timestamp) {
                const now = new Date();
                const date = new Date(timestamp);
                const secondsAgo = Math.floor((now - date) / 1000);

                const minutes = Math.floor(secondsAgo / 60);
                const hours = Math.floor(minutes / 60);
                const days = Math.floor(hours / 24);
                const weeks = Math.floor(days / 7);
                const months = Math.floor(days / 30);

                if (secondsAgo < 60) return "Just now";
                if (minutes < 60) return `${minutes} min ago`;
                if (hours < 24) return `${hours} hrs ago`;
                if (days < 7) return `${days} day${days > 1 ? ''s'' : ''''} ago`;
                if (weeks < 4) return `${weeks} week${weeks > 1 ? ''s'' : ''''} ago`;
                return `${months} month${months > 1 ? ''s'' : ''''} ago`;
            }

            // Extract initials (2 letters max)
            function getInitials(text) {
                return text
                    .split('' '')
                    .map(word => word[0].toUpperCase())
                    .slice(0, 2)
                    .join('''');
            }

            // Construct HTML for each activity
            if (data && data.length == 0) {
                $("#activitylist_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none");
                $("#activitylist_{{axp_cardsid}}").addClass("d-none");
                $("#activitylist_{{axp_cardsid}}").parent().find(".Empty-card-msg").removeClass("d-none");
            }
            else {
                data.forEach(activity => {
                    const li = document.createElement(''li'');
                    li.className = ''ractivity'';

                    li.innerHTML = `
        <div class="ractivity-timeline-dot">
            <span class="material-icons material-icons-style material-icons-2">
                arrow_right
            </span>
        </div>
        <div class="d-flex">
            <div class="thumbnail-icon">
                <div class="symbol symbol-circle symbol-25px">
                    <div class="symbol-label bg-primary">
                        <span class="fs-7 text-inverse-primary">
                            ${getInitials(activity.title || activity.username)}
                        </span>
                    </div>
                </div>
            </div>
            <div class="flex-grow-1 d-flex">
                <div class="ractivity-desc">
                    ${activity.title}
                   
                    <p class="text-muted mb-0">${timeAgo(activity.calledon)}</p>
                </div>
                 ${activity.link ? `<a href="#" class="border-bottom ms-auto" onclick="navigateToUrl(''${activity.link}'')">View Details</a>` : ''''}
            </div>
        </div>
        `;

                    activityList.appendChild(li);
                    $("#activitylist_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none");
                });


                $("#activitylist_{{axp_cardsid}}").parent().find(".placeholder-content").addClass("d-none");



            }
        }, 1)
    </script>
</div>', 'cards')
ON CONFLICT DO NOTHING;

-- Seed: ax_layoutdesign (60 rows)
INSERT INTO {schema}.ax_layoutdesign (design_id, transid, module, content, created_by, updated_by, is_deleted, is_private, created_on, updated_on, is_migrated, is_publish, parent_design_id, responsibility, order_by)
VALUES
('19', 'ad_db', 'TSTRUCT', '[{"transid":"ad_db","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"09/11/2022 18:54:52","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"db_function","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"db_function_params","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"event_onlogin","x":0,"y":2,"width":4,"height":1,"visibility":true},{"fld_id":"event_onformload","x":0,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"forms","x":4,"y":3,"width":32,"height":1,"visibility":true},{"fld_id":"event_onreportload","x":0,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"reports","x":4,"y":4,"width":32,"height":1,"visibility":true},{"fld_id":"remarks","x":0,"y":5,"width":36,"height":2,"visibility":true},{"fld_id":"btn18","x":13,"y":7,"width":3,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"db_varname","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"db_varval","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"db_vartype","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"db_varcaption","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":0,"visibility":false},{"fld_id":"uniqueThHead2","width":65,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"db_varname","width":328,"visibility":true},{"fld_id":"db_varcaption","width":366,"visibility":true},{"fld_id":"db_varval","width":312,"visibility":true},{"fld_id":"db_vartype","width":93,"visibility":true}]}]}]', 'admin', 'admin', 'N', 'N', '2022-09-20 11:27:14', '2022-12-12 04:20:04', 'N', NULL, NULL, NULL, NULL),
('20', 'axstc', 'TSTRUCT', '[{"transid":"axstc","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"09/06/2023 19:11:29","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"asprops","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"descp","x":0,"y":1,"width":26,"height":3,"visibility":true},{"fld_id":"propvalue1","x":0,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"propvalue2","x":7,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"structcaption","x":14,"y":4,"width":12,"height":1,"visibility":true},{"fld_id":"uploadfiletype","x":0,"y":5,"width":26,"height":2,"visibility":true},{"fld_id":"structelements1","x":0,"y":7,"width":26,"height":3,"visibility":true},{"fld_id":"structelements","x":0,"y":10,"width":7,"height":1,"visibility":true},{"fld_id":"etype","x":7,"y":10,"width":7,"height":1,"visibility":true},{"fld_id":"userroles","x":14,"y":10,"width":7,"height":1,"visibility":true},{"fld_id":"purpose","x":0,"y":11,"width":26,"height":2,"visibility":true}],"tableDesign":null}]}]', 'pandi', 'pandi', 'N', 'N', '2019-04-03 18:38:20', '2023-06-09 06:45:22', 'N', NULL, NULL, NULL, NULL),
('21', 'ad_at', 'TSTRUCT', '[{"transid":"ad_at","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/09/2025 19:19:09","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"process","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"taskname","x":14,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"actorname","x":0,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"assignmode","x":0,"y":2,"width":14,"height":1,"visibility":true},{"fld_id":"defusername","x":0,"y":3,"width":28,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"usergroupname","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"ugrpusername","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":28,"visibility":true},{"fld_id":"uniqueThHead2","width":40,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"usergroupname","width":274,"visibility":true},{"fld_id":"usergrpcode","width":0,"visibility":false},{"fld_id":"oldugrpusername","width":0,"visibility":false},{"fld_id":"ugrpusername","width":599,"visibility":true},{"fld_id":"ugrpcnt","width":0,"visibility":false},{"fld_id":"ug_actorname","width":0,"visibility":false}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"tbl_datagrp","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"datagrpusers","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"dgname","x":0,"y":6,"width":24,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":28,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"cndopr","width":0,"visibility":false},{"fld_id":"fldcnd","width":0,"visibility":false},{"fld_id":"dg_actorname","width":0,"visibility":false},{"fld_id":"dgname","width":275,"visibility":true},{"fld_id":"tbl_datagrp","width":300,"visibility":true},{"fld_id":"olddatagrpusers","width":0,"visibility":false},{"fld_id":"datagrpusers","width":359,"visibility":true},{"fld_id":"cndcnt","width":0,"visibility":false}]},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cnd","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"fldcnd","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"cndopr","x":0,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"fldvalue","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":40,"visibility":true},{"fld_id":"uniqueThHead4","width":65,"visibility":true},{"fld_id":"axp_recid4","width":12,"visibility":false},{"fld_id":"cnd","width":134,"visibility":true},{"fld_id":"fldcnd","width":489,"visibility":true},{"fld_id":"stransid","width":12,"visibility":false},{"fld_id":"isformfld","width":12,"visibility":false},{"fld_id":"fldname","width":12,"visibility":false},{"fld_id":"isnum_date","width":12,"visibility":false},{"fld_id":"cndopr","width":289,"visibility":true},{"fld_id":"fldvalue","width":496,"visibility":true},{"fld_id":"cndoprsym","width":12,"visibility":false},{"fld_id":"cndcnt","width":12,"visibility":false},{"fld_id":"condition","width":12,"visibility":false}]}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2022-11-23 21:25:35', '2025-12-02 14:22:02', 'N', '', '0', NULL, '0'),
('23', 'axusr', 'TSTRUCT', '[{"transid":"axusr","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"selectedLayout":"single","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"06/02/2026 12:20:24","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"pusername","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"nickname","x":9,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"pwd","x":21,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"profilepic","x":29,"y":0,"width":5,"height":3,"visibility":true},{"fld_id":"email","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"mobile","x":9,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"dhomepage","x":16,"y":1,"width":13,"height":1,"visibility":true},{"fld_id":"axlang","x":0,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"global_displaytext","x":9,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"appmanager","x":0,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"importstruct","x":5,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"exportstruct","x":9,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"build","x":13,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"portaluser","x":17,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"isuniquehybrid","x":21,"y":3,"width":8,"height":1,"visibility":true},{"fld_id":"pwdauth","x":0,"y":4,"width":5,"height":1,"visibility":true},{"fld_id":"otpauth","x":5,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"actflag","x":9,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"staysignedin","x":13,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"signinexpiry","x":17,"y":4,"width":4,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"axusergroup","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"startdate","x":12,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"enddate","x":21,"y":0,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":28,"visibility":true},{"fld_id":"uniqueThHead2","width":40,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"axusername","width":0,"visibility":false},{"fld_id":"axusergroup","width":249,"visibility":true},{"fld_id":"startdate","width":155,"visibility":true},{"fld_id":"enddate","width":155,"visibility":true},{"fld_id":"validrow2","width":0,"visibility":false}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"charts","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"graphtype","x":24,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":20,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"charts","width":331,"visibility":true},{"fld_id":"chartgroup","width":0,"visibility":false},{"fld_id":"graphtypeflag","width":0,"visibility":false},{"fld_id":"tmp_graphtype","width":0,"visibility":false},{"fld_id":"graphtype","width":322,"visibility":true},{"fld_id":"piecolor","width":0,"visibility":false},{"fld_id":"titlelinkname","width":0,"visibility":false},{"fld_id":"filterlinkname","width":0,"visibility":false},{"fld_id":"sqltext","width":0,"visibility":false},{"fld_id":"hyptext","width":0,"visibility":false}]}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2019-08-06 16:31:24', '2026-02-07 18:07:02', 'N', '', '0', NULL, '0'),
('24', 'pgv2m', 'TSTRUCT', '[{"transid":"pgv2m","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"26/09/2023 16:18:19","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcaption","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"KeyFieldcaption","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"taskgroupname","x":0,"y":2,"width":11,"height":1,"visibility":true},{"fld_id":"TaskName","x":11,"y":2,"width":25,"height":1,"visibility":true},{"fld_id":"assignto","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"assigntoactor","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"AssignToRole","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"useridentificationfilter","x":0,"y":6,"width":31,"height":2,"visibility":true},{"fld_id":"useridentificationfilter_of","x":31,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"formfieldscaption","x":0,"y":8,"width":36,"height":1,"visibility":true},{"fld_id":"skipleveluser","x":0,"y":9,"width":36,"height":1,"visibility":true},{"fld_id":"IndexNo","x":0,"y":10,"width":6,"height":1,"visibility":true},{"fld_id":"ParentTaskName","x":6,"y":10,"width":30,"height":1,"visibility":true},{"fld_id":"applicability_tbl","x":0,"y":11,"width":36,"height":1,"visibility":true},{"fld_id":"groupwithprior","x":0,"y":14,"width":6,"height":1,"visibility":true},{"fld_id":"isoptional","x":6,"y":14,"width":6,"height":1,"visibility":true},{"fld_id":"usebusinessdatelogic","x":12,"y":14,"width":16,"height":1,"visibility":true},{"fld_id":"active","x":28,"y":14,"width":8,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"dummy","x":0,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"DisplayTitle","x":0,"y":0,"width":31,"height":1,"visibility":true},{"fld_id":"DisplayIcon","x":31,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"DIsplayContent","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"displaymcontent","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"TimelineTitle","x":0,"y":5,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cmd","x":0,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"tbldtls","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":41,"visibility":true},{"fld_id":"uniqueThHead4","width":57,"visibility":true},{"fld_id":"axp_recid4","width":0,"visibility":false},{"fld_id":"cmd","width":176,"visibility":true},{"fld_id":"pcnd","width":0,"visibility":false},{"fld_id":"cmdtmp","width":0,"visibility":false},{"fld_id":"setvalueflds","width":0,"visibility":false},{"fld_id":"tbldtls","width":293,"visibility":true},{"fld_id":"axpscript","width":0,"visibility":false},{"fld_id":"axscripttmp","width":0,"visibility":false},{"fld_id":"formctlcnt","width":0,"visibility":false}]},{"dc_id":"5","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"remindnotify","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"rem_startfrom","x":0,"y":13,"width":36,"height":1,"visibility":true},{"fld_id":"rem_when","x":0,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_maildays","x":9,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_mailndays","x":18,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_daytypeui","x":0,"y":15,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct5","width":40,"visibility":true},{"fld_id":"uniqueThHead5","width":47,"visibility":true},{"fld_id":"axp_recid5","width":0,"visibility":false},{"fld_id":"remindafter","width":0,"visibility":false},{"fld_id":"remindday","width":0,"visibility":false},{"fld_id":"reminderhr","width":0,"visibility":false},{"fld_id":"remindmin","width":0,"visibility":false},{"fld_id":"rem_startfrom","width":289,"visibility":true},{"fld_id":"oldrem_startfrom","width":0,"visibility":false},{"fld_id":"remindercnt","width":0,"visibility":false},{"fld_id":"rem_startafter","width":0,"visibility":false},{"fld_id":"rem_when","width":90,"visibility":true},{"fld_id":"rem_maildays","width":103,"visibility":true},{"fld_id":"rem_mailndays","width":147,"visibility":true},{"fld_id":"rem_daytypeui","width":180,"visibility":true},{"fld_id":"rem_daytype","width":155,"visibility":false},{"fld_id":"rem_startfromcnd","width":0,"visibility":false},{"fld_id":"rem_startfromfname","width":0,"visibility":false},{"fld_id":"rem_frequency","width":0,"visibility":false},{"fld_id":"rem_frq_daytype","width":0,"visibility":false},{"fld_id":"remindnotify","width":503,"visibility":true},{"fld_id":"rem_stopafter","width":0,"visibility":false},{"fld_id":"rem_taskparamsui","width":0,"visibility":false}]},{"dc_id":"6","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"escalate","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"escalatetoactor","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"escalatetemplate","x":0,"y":5,"width":24,"height":1,"visibility":true},{"fld_id":"escalate_notifyto","x":0,"y":20,"width":15,"height":1,"visibility":true},{"fld_id":"notifytoactor","x":0,"y":21,"width":36,"height":1,"visibility":true},{"fld_id":"esc_startfrom","x":0,"y":22,"width":36,"height":1,"visibility":true},{"fld_id":"esc_when","x":0,"y":23,"width":9,"height":1,"visibility":true},{"fld_id":"esc_maildays","x":9,"y":23,"width":9,"height":1,"visibility":true},{"fld_id":"esc_mailndays","x":18,"y":23,"width":9,"height":1,"visibility":true},{"fld_id":"esc_daytypeui","x":0,"y":24,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct6","width":40,"visibility":true},{"fld_id":"uniqueThHead6","width":56,"visibility":true},{"fld_id":"axp_recid6","width":0,"visibility":false},{"fld_id":"escalateafter","width":0,"visibility":false},{"fld_id":"escalateday","width":0,"visibility":false},{"fld_id":"escalatehr","width":0,"visibility":false},{"fld_id":"escalatemin","width":0,"visibility":false},{"fld_id":"esc_startfrom","width":347,"visibility":true},{"fld_id":"oldesc_startfrom","width":0,"visibility":false},{"fld_id":"esc_when","width":85,"visibility":true},{"fld_id":"esc_maildays","width":105,"visibility":true},{"fld_id":"esc_mailndays","width":171,"visibility":true},{"fld_id":"esc_daytypeui","width":171,"visibility":true},{"fld_id":"esc_daytype","width":125,"visibility":false},{"fld_id":"escalationcnt","width":0,"visibility":false},{"fld_id":"esc_startfromcnd","width":0,"visibility":false},{"fld_id":"esc_startfromfname","width":0,"visibility":false},{"fld_id":"esc_frequency","width":0,"visibility":false},{"fld_id":"esc_frq_daytype","width":0,"visibility":false},{"fld_id":"escalate","width":296,"visibility":true},{"fld_id":"escalatetoactor","width":332,"visibility":true},{"fld_id":"escalatetemplate","width":332,"visibility":true},{"fld_id":"escalateflg","width":0,"visibility":false},{"fld_id":"escalate_notifyto","width":221,"visibility":true},{"fld_id":"notifytoactor","width":290,"visibility":true},{"fld_id":"esc_taskparamsui","width":0,"visibility":false}]},{"dc_id":"7","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"taskparamsui","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"TaskNotification","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"taskdescription","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"hidecards","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"allowedit","x":0,"y":7,"width":9,"height":1,"visibility":true},{"fld_id":"allowedittasks","x":0,"y":8,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"8","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cardname","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"cardtype","x":0,"y":1,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct8","width":83,"visibility":true},{"fld_id":"uniqueThHead8","width":66,"visibility":true},{"fld_id":"axp_recid8","width":0,"visibility":false},{"fld_id":"cardname","width":435,"visibility":true},{"fld_id":"cardtype","width":201,"visibility":true}]}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-02-24 09:59:55', '2023-09-26 16:19:39', 'N', NULL, NULL, NULL, NULL),
('25', 'pgv2a', 'TSTRUCT', '[{"transid":"pgv2a","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"23/09/2024 11:01:00","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcaption","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"KeyFieldcaption","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"taskgroupname","x":0,"y":2,"width":10,"height":1,"visibility":true},{"fld_id":"TaskName","x":10,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"autoapprove","x":30,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"assignto","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"assigntoactor","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"AssignToRole","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"formfieldscaption","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"skipleveluser","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"useridentificationfilter","x":0,"y":8,"width":31,"height":2,"visibility":true},{"fld_id":"useridentificationfilter_of","x":31,"y":8,"width":5,"height":1,"visibility":true},{"fld_id":"allowsend","x":0,"y":10,"width":36,"height":1,"visibility":true},{"fld_id":"senduser_in","x":0,"y":11,"width":36,"height":2,"visibility":true},{"fld_id":"senduser_notin","x":0,"y":13,"width":36,"height":2,"visibility":true},{"fld_id":"sendtoactor","x":0,"y":15,"width":36,"height":2,"visibility":true},{"fld_id":"IndexNo","x":0,"y":17,"width":7,"height":1,"visibility":true},{"fld_id":"ParentTaskName","x":7,"y":17,"width":29,"height":1,"visibility":true},{"fld_id":"groupwithprior","x":0,"y":18,"width":7,"height":1,"visibility":true},{"fld_id":"approve_forwardto","x":7,"y":18,"width":9,"height":1,"visibility":true},{"fld_id":"initiator_approval","x":16,"y":18,"width":9,"height":1,"visibility":true},{"fld_id":"orphan_autoapproval","x":25,"y":18,"width":11,"height":1,"visibility":true},{"fld_id":"returnable","x":0,"y":19,"width":7,"height":1,"visibility":true},{"fld_id":"return_to_priorindex","x":7,"y":19,"width":9,"height":1,"visibility":true},{"fld_id":"usebusinessdatelogic","x":16,"y":19,"width":11,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":20,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"10","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"PostNotify","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"PostNotify_return","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"PostNotify_reject","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"TaskNotification","x":0,"y":6,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"11","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cmsg_appcheck","x":0,"y":0,"width":29,"height":2,"visibility":true},{"fld_id":"cmsg_return","x":0,"y":2,"width":29,"height":2,"visibility":true},{"fld_id":"cmsg_reject","x":0,"y":4,"width":29,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"DisplayTitle","x":0,"y":0,"width":22,"height":1,"visibility":true},{"fld_id":"DisplayIcon","x":22,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"showbuttons","x":28,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"DIsplayContent","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"displaymcontent","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"TimelineTitle","x":0,"y":5,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cmd","x":0,"y":3,"width":12,"height":1,"visibility":true},{"fld_id":"tbldtls","x":0,"y":4,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":40,"visibility":true},{"fld_id":"uniqueThHead4","width":64,"visibility":true},{"fld_id":"axp_recid4","width":0,"visibility":false},{"fld_id":"cmd","width":248,"visibility":true},{"fld_id":"pcnd","width":0,"visibility":false},{"fld_id":"cmdtmp","width":0,"visibility":false},{"fld_id":"fctlfldcaption","width":0,"visibility":false},{"fld_id":"tbldtls","width":838,"visibility":true},{"fld_id":"axpscript","width":0,"visibility":false},{"fld_id":"axscripttmp","width":0,"visibility":false},{"fld_id":"setvalueflds","width":0,"visibility":false},{"fld_id":"formctlcnt","width":0,"visibility":false}]},{"dc_id":"5","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"setval_formcaption","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"tblsetval","x":0,"y":1,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct5","width":43,"visibility":true},{"fld_id":"uniqueThHead5","width":59,"visibility":true},{"fld_id":"axp_recid5","width":0,"visibility":false},{"fld_id":"setval_formcaption","width":570,"visibility":true},{"fld_id":"setval_formname","width":0,"visibility":false},{"fld_id":"setval_fldcap","width":0,"visibility":false},{"fld_id":"setval_fldname","width":0,"visibility":false},{"fld_id":"tblsetval","width":789,"visibility":true},{"fld_id":"setvalscr","width":0,"visibility":false},{"fld_id":"rulesetvalscr","width":0,"visibility":false}]},{"dc_id":"6","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"remindnotify","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"rem_startfrom","x":0,"y":13,"width":36,"height":1,"visibility":true},{"fld_id":"rem_when","x":0,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_maildays","x":9,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_mailndays","x":18,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_daytypeui","x":0,"y":15,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct6","width":40,"visibility":true},{"fld_id":"uniqueThHead6","width":46,"visibility":true},{"fld_id":"axp_recid6","width":0,"visibility":false},{"fld_id":"remindafter","width":0,"visibility":false},{"fld_id":"remindday","width":0,"visibility":false},{"fld_id":"reminderhr","width":0,"visibility":false},{"fld_id":"remindmin","width":0,"visibility":false},{"fld_id":"rem_startfrom","width":288,"visibility":true},{"fld_id":"oldrem_startfrom","width":0,"visibility":false},{"fld_id":"rem_when","width":82,"visibility":true},{"fld_id":"rem_maildays","width":98,"visibility":true},{"fld_id":"rem_mailndays","width":158,"visibility":true},{"fld_id":"rem_daytypeui","width":198,"visibility":true},{"fld_id":"rem_daytype","width":0,"visibility":false},{"fld_id":"remindercnt","width":0,"visibility":false},{"fld_id":"rem_startafter","width":0,"visibility":false},{"fld_id":"rem_startfromcnd","width":0,"visibility":false},{"fld_id":"rem_startfromfname","width":0,"visibility":false},{"fld_id":"rem_frequency","width":0,"visibility":false},{"fld_id":"rem_frq_daytype","width":0,"visibility":false},{"fld_id":"remindnotify","width":501,"visibility":true},{"fld_id":"rem_stopafter","width":0,"visibility":false},{"fld_id":"rem_taskparamsui","width":0,"visibility":false}]},{"dc_id":"7","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"escalate","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"escalatetoactor","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"escalatetemplate","x":0,"y":5,"width":24,"height":1,"visibility":true},{"fld_id":"escalate_notifyto","x":0,"y":17,"width":15,"height":1,"visibility":true},{"fld_id":"notifytoactor","x":0,"y":18,"width":36,"height":1,"visibility":true},{"fld_id":"esc_startfrom","x":0,"y":19,"width":36,"height":1,"visibility":true},{"fld_id":"esc_when","x":0,"y":20,"width":9,"height":1,"visibility":true},{"fld_id":"esc_maildays","x":9,"y":20,"width":9,"height":1,"visibility":true},{"fld_id":"esc_mailndays","x":18,"y":20,"width":9,"height":1,"visibility":true},{"fld_id":"esc_daytypeui","x":0,"y":21,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct7","width":43,"visibility":true},{"fld_id":"uniqueThHead7","width":40,"visibility":true},{"fld_id":"axp_recid7","width":0,"visibility":false},{"fld_id":"escalateafter","width":0,"visibility":false},{"fld_id":"esc_startfrom","width":306,"visibility":true},{"fld_id":"esc_when","width":77,"visibility":true},{"fld_id":"esc_maildays","width":94,"visibility":true},{"fld_id":"esc_mailndays","width":175,"visibility":true},{"fld_id":"esc_daytypeui","width":171,"visibility":true},{"fld_id":"esc_daytype","width":0,"visibility":false},{"fld_id":"esc_startfromfname","width":0,"visibility":false},{"fld_id":"esc_startfromcnd","width":0,"visibility":false},{"fld_id":"esc_frequency","width":0,"visibility":false},{"fld_id":"esc_frq_daytype","width":0,"visibility":false},{"fld_id":"escalateday","width":0,"visibility":false},{"fld_id":"escalatehr","width":0,"visibility":false},{"fld_id":"escalatemin","width":0,"visibility":false},{"fld_id":"escalate","width":271,"visibility":true},{"fld_id":"escalateflg","width":0,"visibility":false},{"fld_id":"escalatetoactor","width":303,"visibility":true},{"fld_id":"escalatetemplate","width":318,"visibility":true},{"fld_id":"escalate_notifyto","width":224,"visibility":true},{"fld_id":"notifytoactor","width":256,"visibility":true},{"fld_id":"oldesc_startfrom","width":0,"visibility":false},{"fld_id":"esc_taskparamsui","width":0,"visibility":false}]},{"dc_id":"8","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"taskparamsui","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"taskdescription","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"hidecards","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"allowedit","x":0,"y":5,"width":9,"height":1,"visibility":true},{"fld_id":"allowedittasks","x":0,"y":6,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"9","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"approvecmt","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"returncmt","x":9,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"rejectcmt","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"approvereasons","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"defapptext","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"returnreasons","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"defrettext","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"RejectReasons","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"defregtext","x":0,"y":6,"width":36,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-02-24 20:28:28', '2024-09-23 11:02:55', 'N', NULL, NULL, NULL, NULL),
('26', 'ad_ur', 'TSTRUCT', '[{"transid":"ad_ur","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"27/11/2024 17:50:04","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"axusergroup","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"btn17","x":15,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"dhomepage","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"useprodform","x":15,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', '', 'N', 'N', '2024-12-13 08:24:16', '2024-12-13 08:24:16', 'N', '', '0', NULL, '0'),
('27', 'ad_pn', 'TSTRUCT', '[{"transid":"ad_pn","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"29/05/2023 19:36:25","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"name","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"processname","x":9,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"taskname","x":23,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"NotifyTo","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"fromfieldcaption","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"roles","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"actors","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"taskparams","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"tasklist","x":0,"y":8,"width":36,"height":1,"visibility":true},{"fld_id":"emailaddr","x":0,"y":9,"width":36,"height":1,"visibility":true},{"fld_id":"EnableEmail","x":0,"y":10,"width":9,"height":1,"visibility":true},{"fld_id":"EnableSMS","x":9,"y":10,"width":9,"height":1,"visibility":true},{"fld_id":"EnableWhatsapp","x":18,"y":10,"width":9,"height":1,"visibility":true},{"fld_id":"enablemobilenotify","x":27,"y":10,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"emailsubject","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"emailattachment","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"EmailText","x":0,"y":3,"width":36,"height":7,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notifyto_cc","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"fromfieldcaption_cc","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"roles_cc","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"actors_cc","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"taskparams_cc","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"tasklist_cc","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"emailaddr_cc","x":0,"y":8,"width":36,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notifyto_bcc","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"fromfieldcaption_bcc","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"roles_bcc","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"actors_bcc","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"taskparams_bcc","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"tasklist_bcc","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"emailaddr_bcc","x":0,"y":8,"width":36,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"5","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"SMStext","x":0,"y":0,"width":36,"height":4,"visibility":true}],"tableDesign":null},{"dc_id":"6","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"WhatsApptext","x":0,"y":0,"width":36,"height":4,"visibility":true}],"tableDesign":null},{"dc_id":"7","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"mobile_title","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"mobile_content","x":0,"y":1,"width":36,"height":3,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2022-11-07 12:32:12', '2023-05-29 19:36:39', 'N', NULL, NULL, NULL, NULL),
('28', 'ad_pm', 'TSTRUCT', '[{"transid":"ad_pm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"11/07/2023 16:29:16","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"caption","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"processowner","x":9,"y":0,"width":10,"height":1,"visibility":true},{"fld_id":"axpicon_process","x":19,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"processtable","x":24,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"processdesc","x":0,"y":1,"width":30,"height":3,"visibility":true},{"fld_id":"cards","x":0,"y":4,"width":30,"height":1,"visibility":true},{"fld_id":"amendment","x":0,"y":5,"width":5,"height":1,"visibility":true},{"fld_id":"amendconfirm","x":5,"y":5,"width":9,"height":1,"visibility":true},{"fld_id":"amendconfirmmsg","x":0,"y":6,"width":14,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2022-10-19 01:58:28', '2023-07-11 16:30:47', 'N', NULL, NULL, NULL, NULL),
('30', 'ad_am', 'TSTRUCT', '[{"transid":"ad_am","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"14/05/2023 10:02:03","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"actorname","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"applicableto","x":17,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"sprocessname","x":0,"y":1,"width":28,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', 'N', '2023-05-14 10:02:57', '2023-05-14 10:02:57', 'N', NULL, NULL, NULL, NULL),
('31', 'ad__q', 'TSTRUCT', '[{"transid":"ad__q","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"27/11/2024 15:59:19","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxQueueName","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"AxQueueDesc","x":0,"y":1,"width":24,"height":2,"visibility":true},{"fld_id":"formcaption","x":0,"y":3,"width":24,"height":1,"visibility":true},{"fld_id":"allfields","x":24,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"formfields","x":0,"y":4,"width":24,"height":2,"visibility":true},{"fld_id":"onformdata","x":24,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"primaryfieldui","x":0,"y":6,"width":24,"height":1,"visibility":true},{"fld_id":"datasource","x":0,"y":7,"width":24,"height":1,"visibility":true},{"fld_id":"ds_forms","x":0,"y":8,"width":24,"height":2,"visibility":true},{"fld_id":"ds_interval","x":0,"y":10,"width":24,"height":1,"visibility":true},{"fld_id":"printforms","x":0,"y":11,"width":7,"height":1,"visibility":true},{"fld_id":"fileattachments","x":7,"y":11,"width":7,"height":1,"visibility":true},{"fld_id":"active","x":14,"y":11,"width":9,"height":1,"visibility":true},{"fld_id":"fastprints","x":0,"y":12,"width":24,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2024-01-11 14:55:16', '2024-11-27 16:00:28', 'N', NULL, NULL, NULL, NULL),
('32', 'a__re', 'TSTRUCT', '[{"transid":"a__re","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"05/05/2025 20:55:13","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"rulename","x":0,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"formcaption","x":11,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"uroles","x":0,"y":1,"width":26,"height":2,"visibility":true},{"fld_id":"formula","x":0,"y":3,"width":26,"height":1,"visibility":true},{"fld_id":"showfieldsui","x":0,"y":4,"width":26,"height":2,"visibility":true},{"fld_id":"hidefieldsui","x":0,"y":6,"width":26,"height":2,"visibility":true},{"fld_id":"enablefieldsui","x":0,"y":8,"width":26,"height":2,"visibility":true},{"fld_id":"disablefieldsui","x":0,"y":10,"width":26,"height":2,"visibility":true},{"fld_id":"mandatoryfieldsui","x":0,"y":12,"width":26,"height":2,"visibility":true},{"fld_id":"nonmandatoryfieldsui","x":0,"y":14,"width":26,"height":2,"visibility":true},{"fld_id":"fldsmasking","x":0,"y":16,"width":26,"height":1,"visibility":true},{"fld_id":"readonly","x":0,"y":17,"width":5,"height":1,"visibility":true},{"fld_id":"cachedsave","x":5,"y":17,"width":5,"height":1,"visibility":true},{"fld_id":"active","x":10,"y":17,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', 'N', '2025-05-05 20:56:55', '2025-05-05 20:56:55', 'N', NULL, NULL, NULL, NULL),
('34', 'a__iq', 'TSTRUCT', '[{"transid":"a__iq","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"14/12/2023 22:08:05","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxQueueName","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"AxQueueDesc","x":0,"y":1,"width":24,"height":2,"visibility":true},{"fld_id":"unameui","x":0,"y":3,"width":14,"height":1,"visibility":true},{"fld_id":"secretkey","x":14,"y":3,"width":10,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":5,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-09-27 09:45:22', '2023-12-14 22:08:57', 'N', NULL, NULL, NULL, NULL),
('51', 'axcdm', 'TSTRUCT', '[{"transid":"axcdm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"28/04/2021 14:46:55","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cardtype","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"cardcaption","x":6,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"cardicon","x":0,"y":1,"width":8,"height":1,"visibility":true},{"fld_id":"AxpFile_cardimg","x":8,"y":1,"width":10,"height":1,"visibility":true},{"fld_id":"AxpFilePath_cardimg","x":0,"y":2,"width":18,"height":1,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', 'N', '2021-04-28 13:41:57', '2021-04-28 14:50:36', 'N', NULL, NULL, NULL, NULL),
('35', 'a__fn', 'TSTRUCT', '[{"transid":"a__fn","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"29/07/2024 17:54:16","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"form","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"formula","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notifyto","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"usergroups","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"usernames","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"formfield","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"whatsapp_usernames","x":0,"y":7,"width":21,"height":2,"visibility":true},{"fld_id":"whatsapp_formfield","x":21,"y":7,"width":15,"height":1,"visibility":true},{"fld_id":"sms_usernames","x":0,"y":9,"width":21,"height":2,"visibility":true},{"fld_id":"sms_formfield","x":21,"y":9,"width":15,"height":1,"visibility":true},{"fld_id":"isemailreq","x":0,"y":11,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notify_msg_prints","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"notify_sub_new","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_new","x":0,"y":2,"width":36,"height":3,"visibility":true},{"fld_id":"notify_sub_edit","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_edit","x":0,"y":6,"width":36,"height":3,"visibility":true},{"fld_id":"notify_sub_cancel","x":0,"y":9,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_cancel","x":0,"y":10,"width":36,"height":3,"visibility":true},{"fld_id":"notify_sub_delete","x":0,"y":13,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_delete","x":0,"y":14,"width":36,"height":3,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"emailto","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"emailto_usernames","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"emailto_usergroups","x":0,"y":4,"width":17,"height":2,"visibility":true},{"fld_id":"emailto_formfield","x":17,"y":4,"width":19,"height":1,"visibility":true},{"fld_id":"emailcc","x":0,"y":6,"width":36,"height":2,"visibility":true},{"fld_id":"emailcc_usernames","x":0,"y":8,"width":36,"height":2,"visibility":true},{"fld_id":"emailcc_usergroups","x":0,"y":10,"width":17,"height":2,"visibility":true},{"fld_id":"emailcc_formfield","x":17,"y":10,"width":19,"height":1,"visibility":true},{"fld_id":"emailbcc","x":0,"y":12,"width":36,"height":2,"visibility":true},{"fld_id":"emailbcc_usernames","x":0,"y":14,"width":36,"height":2,"visibility":true},{"fld_id":"emailbcc_usergroups","x":0,"y":16,"width":17,"height":2,"visibility":true},{"fld_id":"emailbcc_formfield","x":17,"y":16,"width":19,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"5","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"email_msg_prints","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"email_msg_attachmentsui","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"email_sub_new","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_new","x":0,"y":6,"width":36,"height":5,"visibility":true},{"fld_id":"email_sub_edit","x":0,"y":11,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_edit","x":0,"y":12,"width":36,"height":5,"visibility":true},{"fld_id":"email_sub_cancel","x":0,"y":17,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_cancel","x":0,"y":18,"width":36,"height":5,"visibility":true},{"fld_id":"email_sub_delete","x":0,"y":23,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_delete","x":0,"y":24,"width":36,"height":5,"visibility":true}],"tableDesign":null},{"dc_id":"6","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"navigateto","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"loadopen","x":21,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_navigationparam","x":0,"y":1,"width":27,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-08-01 12:23:16', '2024-07-29 17:54:52', 'N', NULL, NULL, NULL, NULL),
('36', 'a__er', 'TSTRUCT', '[{"transid":"a__er","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"13/05/2024 11:56:39","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"rtypeui","x":0,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"mstructui","x":0,"y":1,"width":20,"height":1,"visibility":true},{"fld_id":"mfieldui","x":0,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"dstructui","x":0,"y":3,"width":20,"height":1,"visibility":true},{"fld_id":"dfieldui","x":0,"y":4,"width":20,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', 'N', '2024-05-13 11:57:27', '2024-05-13 11:57:27', 'N', NULL, NULL, NULL, NULL),
('37', 'a__ug', 'TSTRUCT', '[{"transid":"a__ug","compressedMode":false,"newDesign":true,"staticRunMode":true,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"16/12/2024 15:25:29","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"users_group_name","x":0,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"users_group_description","x":0,"y":1,"width":31,"height":1,"visibility":true},{"fld_id":"isactive","x":0,"y":2,"width":4,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-11-04 20:29:00', '2024-12-19 17:19:24', 'N', '', '0', NULL, '0'),
('39', 'a__na', 'TSTRUCT', '[{"transid":"a__na","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"10/03/2025 16:49:18","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"title","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"eventimg","x":21,"y":0,"width":6,"height":4,"visibility":true},{"fld_id":"subdetails","x":0,"y":1,"width":21,"height":2,"visibility":true},{"fld_id":"redirecturl","x":0,"y":3,"width":21,"height":1,"visibility":true},{"fld_id":"effectfrom","x":0,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"effecto","x":6,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":5,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2025-03-10 16:49:57', '2025-03-10 16:55:43', 'N', NULL, NULL, NULL, NULL),
('47', 'a__td', 'TSTRUCT', '[{"transid":"a__td","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"29/01/2025 17:28:05","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"dname","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"tjson","x":0,"y":1,"width":28,"height":5,"visibility":true},{"fld_id":"isactive","x":0,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', 'N', '2025-01-29 17:28:20', '2025-01-29 17:28:20', 'N', NULL, NULL, NULL, NULL),
('40', 'ad_af', 'TSTRUCT', '[{"transid":"ad_af","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"20-02-2025 15:26:05","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcaption","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"dcName","x":16,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"name","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"caption","x":9,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"fType","x":0,"y":2,"width":12,"height":1,"visibility":true},{"fld_id":"dataType","x":12,"y":2,"width":7,"height":1,"visibility":true},{"fld_id":"width","x":19,"y":2,"width":7,"height":1,"visibility":true},{"fld_id":"flddecimal","x":26,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"DSFormCaptionui","x":0,"y":3,"width":12,"height":1,"visibility":true},{"fld_id":"DSFieldui","x":12,"y":3,"width":20,"height":1,"visibility":true},{"fld_id":"defList","x":0,"y":4,"width":32,"height":2,"visibility":true},{"fld_id":"apiNameMO","x":0,"y":6,"width":32,"height":1,"visibility":true},{"fld_id":"defSrcFieldui","x":0,"y":7,"width":17,"height":1,"visibility":true},{"fld_id":"defTable","x":0,"y":8,"width":32,"height":5,"visibility":true},{"fld_id":"autogenprefix","x":0,"y":30,"width":5,"height":1,"visibility":true},{"fld_id":"autogenprefixfld","x":5,"y":30,"width":10,"height":1,"visibility":true},{"fld_id":"autogensno","x":15,"y":30,"width":4,"height":1,"visibility":true},{"fld_id":"autogenno","x":19,"y":30,"width":4,"height":1,"visibility":true},{"fld_id":"rangeperiod","x":23,"y":30,"width":9,"height":1,"visibility":true},{"fld_id":"exp_editor_formula","x":0,"y":31,"width":32,"height":2,"visibility":true},{"fld_id":"exp_editor_valexpr","x":0,"y":33,"width":32,"height":2,"visibility":true},{"fld_id":"allowDuplicate","x":0,"y":35,"width":6,"height":1,"visibility":true},{"fld_id":"allowEmpty","x":6,"y":35,"width":6,"height":1,"visibility":true},{"fld_id":"fldPosition","x":0,"y":36,"width":7,"height":1,"visibility":true},{"fld_id":"position","x":7,"y":36,"width":25,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2022-06-30 12:37:13', '2025-02-20 15:28:00', 'N', NULL, NULL, NULL, NULL),
('41', 'ad_pa', 'TSTRUCT', '[{"transid":"ad_pa","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"20/02/2025 15:56:28","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"publickey","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"secretkey","x":16,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"unameui","x":0,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"apitype","x":16,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"objdatasrc","x":0,"y":2,"width":31,"height":2,"visibility":true},{"fld_id":"structcapui","x":0,"y":4,"width":16,"height":1,"visibility":true},{"fld_id":"scriptcapui","x":16,"y":4,"width":8,"height":1,"visibility":true},{"fld_id":"printform","x":24,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"apirequeststring","x":0,"y":5,"width":31,"height":3,"visibility":true},{"fld_id":"apisuccess","x":0,"y":9,"width":31,"height":2,"visibility":true},{"fld_id":"apierror","x":0,"y":11,"width":31,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-12-06 20:03:04', '2025-02-20 15:56:45', 'N', NULL, NULL, NULL, NULL),
('42', 'a__qm', 'TSTRUCT', '[{"transid":"a__qm","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"27/09/2023 09:34:22","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxQueueName","x":0,"y":0,"width":25,"height":1,"visibility":true},{"fld_id":"AxQueueDesc","x":0,"y":1,"width":25,"height":2,"visibility":true},{"fld_id":"btn17","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"btn18","x":9,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-08-16 09:35:11', '2023-09-27 09:35:18', 'N', NULL, NULL, NULL, NULL),
('43', 'axipd', 'TSTRUCT', '[{"transid":"axipd","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"01/09/2021 18:26:37","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxImpDefName","x":0,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"AxImpform","x":8,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"AxImpPrimayField","x":0,"y":1,"width":8,"height":1,"visibility":true},{"fld_id":"AxImpGroupField","x":8,"y":1,"width":10,"height":1,"visibility":true},{"fld_id":"AxImpHeaderRows","x":18,"y":1,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpFieldSeperatorui","x":0,"y":2,"width":5,"height":1,"visibility":true},{"fld_id":"AxImpThreadCount","x":5,"y":2,"width":3,"height":1,"visibility":true},{"fld_id":"AxImpProcessMode","x":8,"y":2,"width":14,"height":1,"visibility":true},{"fld_id":"AxImpMapFields","x":0,"y":3,"width":22,"height":1,"visibility":true},{"fld_id":"AxImpProcName","x":0,"y":4,"width":18,"height":1,"visibility":true},{"fld_id":"AxImpStdColumnWidth","x":18,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpTextQualifier","x":0,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpMapInFile","x":4,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpBindToTStruct","x":8,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpIgnoreFldException","x":12,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"AxImpOnlyAppend","x":18,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpFilefromtable","x":0,"y":6,"width":5,"height":1,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', 'N', '2021-03-31 19:42:32', '2021-09-01 19:00:10', 'N', NULL, NULL, NULL, NULL),
('45', 'axrol', 'TSTRUCT', '[{"transid":"axrol","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"29/09/2021 16:30:28","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"groupname","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"roletype","x":6,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"dhomepage","x":0,"y":1,"width":12,"height":1,"visibility":true},{"fld_id":"selfregistration","x":0,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"apprequired","x":6,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"approvedby","x":0,"y":3,"width":12,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":4,"width":3,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"roles_id","x":0,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":89,"visibility":true},{"fld_id":"uniqueThHead2","width":82,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"roles_id","width":412,"visibility":true}]}]}]', '', '', 'N', 'N', '2018-12-29 12:08:09', '2021-09-29 17:07:07', 'N', '', '0', NULL, '0'),
('46', 'sect', 'TSTRUCT', '[{"transid":"sect","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"10-01-2025 16:09:20","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"caption","x":1,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"template","x":16,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"btn26","x":25,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"AxpFile_hpImages","x":1,"y":3,"width":33,"height":1,"visibility":true},{"fld_id":"params","x":1,"y":5,"width":27,"height":1,"visibility":true},{"fld_id":"isacoretrans","x":28,"y":5,"width":6,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"html_editor_htmlsrc","x":0,"y":0,"width":36,"height":6,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"filename","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"css_js_src","x":0,"y":2,"width":36,"height":6,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":40,"visibility":true},{"fld_id":"uniqueThHead3","width":42,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"filename","width":579,"visibility":true},{"fld_id":"filetype","width":0,"visibility":false},{"fld_id":"css_js_src","width":579,"visibility":true}]},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"filename","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"css_editor_css_js_src","x":0,"y":1,"width":36,"height":5,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":11,"visibility":true},{"fld_id":"uniqueThHead4","width":68,"visibility":true},{"fld_id":"axp_recid4","width":11,"visibility":false},{"fld_id":"filename","width":210,"visibility":true},{"fld_id":"css_editor_css_js_src","width":400,"visibility":true}]}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2020-10-30 12:55:42', '2025-02-04 12:08:58', 'N', NULL, NULL, NULL, NULL),
('48', 'axeml', 'TSTRUCT', '[{"transid":"axeml","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"08/06/2021 16:25:31","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"EMailDefName","x":0,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"EMailWhat","x":11,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"emailform","x":0,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"emailiview","x":0,"y":2,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailTo","x":0,"y":3,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailCC","x":0,"y":4,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailBCC","x":0,"y":5,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailSubject","x":0,"y":6,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailAttachment","x":0,"y":7,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailBody","x":0,"y":8,"width":23,"height":6,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', 'N', '2021-03-26 22:25:10', '2021-06-08 16:29:58', 'N', NULL, NULL, NULL, NULL),
('49', 'ad_li', 'TSTRUCT', '[{"transid":"ad_li","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"24/03/2023 18:33:12","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"dispname","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"sname","x":0,"y":1,"width":24,"height":1,"visibility":true},{"fld_id":"compname","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"compcaption","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"comphint","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"lngname","x":0,"y":5,"width":9,"height":1,"visibility":true},{"fld_id":"fontname","x":0,"y":6,"width":24,"height":1,"visibility":true},{"fld_id":"fontsize","x":0,"y":7,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-03-28 10:44:05', '2023-03-28 10:44:35', 'N', NULL, NULL, NULL, NULL),
('50', 'axpub', 'TSTRUCT', '[{"transid":"axpub","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":true,"selectedLayout":"default","tstUpdatedOn":"19/10/2022 15:35:44","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"servertype","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"servername","x":0,"y":1,"width":17,"height":1,"visibility":true},{"fld_id":"serverpath","x":0,"y":2,"width":17,"height":1,"visibility":true},{"fld_id":"app_connection","x":0,"y":3,"width":17,"height":1,"visibility":true},{"fld_id":"fs_username","x":0,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"fs_password","x":9,"y":4,"width":8,"height":1,"visibility":true},{"fld_id":"ftp_dir","x":0,"y":5,"width":17,"height":1,"visibility":true},{"fld_id":"publishtodev","x":0,"y":6,"width":7,"height":1,"visibility":true},{"fld_id":"inactive","x":7,"y":6,"width":3,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"uploadtype","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"ftp_url","x":0,"y":1,"width":22,"height":1,"visibility":true},{"fld_id":"ftp_dir","x":0,"y":2,"width":22,"height":1,"visibility":true},{"fld_id":"ftp_username","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"ftp_pwd","x":9,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"ftp_port","x":18,"y":3,"width":4,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"db_type","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"db_version","x":9,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"db_host","x":16,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"db_username","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"db_pwd","x":9,"y":1,"width":7,"height":1,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', 'N', '2021-03-18 20:54:00', '2022-10-19 03:11:04', 'N', NULL, NULL, NULL, NULL),
('52', 'axapi', 'TSTRUCT', '[{"transid":"axapi","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"17/05/2022 11:33:06","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"apicategory","x":0,"y":0,"width":18,"height":1,"visibility":true},{"fld_id":"sql_output","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"formcaption","x":0,"y":1,"width":18,"height":1,"visibility":true},{"fld_id":"dd_caption","x":18,"y":1,"width":17,"height":1,"visibility":true},{"fld_id":"iviewcaption","x":0,"y":2,"width":35,"height":1,"visibility":true},{"fld_id":"page","x":0,"y":3,"width":6,"height":1,"visibility":true},{"fld_id":"pagecaption","x":6,"y":3,"width":16,"height":1,"visibility":true},{"fld_id":"pagescript","x":22,"y":3,"width":13,"height":1,"visibility":true},{"fld_id":"sql_reffield","x":0,"y":4,"width":35,"height":1,"visibility":true},{"fld_id":"sql_editor_apiquery","x":0,"y":5,"width":35,"height":2,"visibility":true},{"fld_id":"apiurl","x":0,"y":7,"width":35,"height":1,"visibility":true},{"fld_id":"reqformat","x":0,"y":8,"width":35,"height":7,"visibility":true},{"fld_id":"res_success","x":0,"y":15,"width":35,"height":2,"visibility":true},{"fld_id":"res_fail","x":0,"y":17,"width":35,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2021-10-26 17:02:49', '2022-05-17 11:36:47', 'N', NULL, NULL, NULL, NULL),
('53', 'astcp', 'TSTRUCT', '[{"transid":"astcp","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"tstUpdatedOn":"05/05/2020 16:47:00","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"configprops","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"propcode","x":9,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"ptype","x":17,"y":0,"width":4,"height":1,"visibility":true},{"fld_id":"caction","x":21,"y":0,"width":4,"height":1,"visibility":true},{"fld_id":"description","x":0,"y":1,"width":21,"height":4,"visibility":true},{"fld_id":"chyperlink","x":21,"y":1,"width":4,"height":1,"visibility":true},{"fld_id":"cfields","x":21,"y":2,"width":5,"height":1,"visibility":true},{"fld_id":"alltstructs","x":21,"y":3,"width":8,"height":1,"visibility":true},{"fld_id":"alliviews","x":21,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"alluserroles","x":29,"y":4,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"configvalues","x":0,"y":0,"width":21,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":87,"visibility":true},{"fld_id":"uniqueThHead2","width":95,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"configvalues","width":326,"visibility":true}]}]}]', 'admin', 'admin', NULL, NULL, NULL, '2020-05-05 16:47:38', NULL, NULL, NULL, NULL, NULL),
('54', 'agspr', 'TSTRUCT', '[{"transid":"agspr","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"25/06/2024 19:10:12","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"hltype","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"caption","x":9,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"searchfor","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"searchtext","x":9,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"periodically","x":0,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"fromdt","x":9,"y":2,"width":8,"height":1,"visibility":true},{"fld_id":"todt","x":17,"y":2,"width":8,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"srctrans","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"tsrcfield","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"params","x":0,"y":0,"width":36,"height":1,"visibility":true}],"tableDesign":null}]}]', NULL, NULL, 'N', 'N', '2019-03-07 13:33:07', '2024-06-25 19:13:24', 'N', NULL, NULL, NULL, NULL),
('55', 'ad__e', 'TSTRUCT', '[{"transid":"ad__e","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"16/12/2022 11:45:44","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"eventname","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"eventcolor","x":15,"y":0,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"eventstatus","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"eventstatcolor","x":0,"y":1,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":112,"visibility":true},{"fld_id":"uniqueThHead2","width":68,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"eventstatus","width":432,"visibility":true},{"fld_id":"eventstatcolor","width":245,"visibility":true}]}]}]', 'admin', 'admin', 'N', 'N', '2022-12-13 23:44:38', '2022-12-15 22:58:38', 'N', NULL, NULL, NULL, NULL),
('56', 'pgv2c', 'TSTRUCT', '[{"transid":"pgv2c","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/04/2023 19:27:07","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"TaskName","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"applicability_tbl","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"taskgroupname","x":0,"y":2,"width":26,"height":1,"visibility":true},{"fld_id":"IndexNo","x":26,"y":2,"width":10,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":3,"width":4,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"taskdescription","x":0,"y":1,"width":36,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-02-24 13:03:42', '2023-04-25 19:28:34', 'N', NULL, NULL, NULL, NULL),
('57', 'ad_td', 'TSTRUCT', '[{"transid":"ad_td","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"24/01/2023 20:06:50","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[{"ftype":"field","id":"fromuser000F1","fontFamilly":"font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: rgb(128, 0, 128);","fontFamillyCode":"[Arial,f,f,f,clPurple,f,9]","hyperlinkJson":""}],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"fromuser","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"touser","x":0,"y":1,"width":12,"height":1,"visibility":true},{"fld_id":"fromdate","x":0,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"todate","x":6,"y":2,"width":6,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-01-24 20:07:23', '2023-01-24 21:30:07', 'N', NULL, NULL, NULL, NULL),
('58', 'ad_cp', 'TSTRUCT', '[{"transid":"ad_cp","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"28/04/2023 19:31:51","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cardtype","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"charttype","x":6,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"cardname","x":17,"y":0,"width":19,"height":1,"visibility":true},{"fld_id":"SQL_editor_cardsql","x":0,"y":1,"width":36,"height":6,"visibility":true},{"fld_id":"chartprops","x":0,"y":7,"width":36,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-04-28 19:28:22', '2023-04-28 19:33:00', 'N', NULL, NULL, NULL, NULL),
('59', 'a__sm', 'TSTRUCT', '[{"transid":"a__sm","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"10/12/2023 12:02:22","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"touser_ui","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"msgtitle","x":0,"y":1,"width":21,"height":1,"visibility":true},{"fld_id":"message","x":0,"y":2,"width":21,"height":2,"visibility":true},{"fld_id":"pagetype","x":0,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"formmode","x":9,"y":4,"width":12,"height":1,"visibility":true},{"fld_id":"formcaption","x":0,"y":5,"width":21,"height":1,"visibility":true},{"fld_id":"loadparams","x":0,"y":6,"width":21,"height":1,"visibility":true},{"fld_id":"hlink_transid","x":0,"y":7,"width":21,"height":1,"visibility":true},{"fld_id":"hlink_params","x":0,"y":8,"width":21,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-12-10 11:14:13', '2023-12-10 12:05:44', 'N', NULL, NULL, NULL, NULL),
('67', 'axerr', 'TSTRUCT', '[{"transid":"axerr","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"26/06/2019 19:15:02","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"constraint_name","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"constraint_type","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"table_name","x":0,"y":2,"width":11,"height":1,"visibility":true},{"fld_id":"msg","x":0,"y":3,"width":15,"height":2,"visibility":true}],"tableDesign":null}]}]', 'admin', NULL, 'N', 'N', '2019-08-09 11:20:12', '2019-08-09 11:20:12', 'N', NULL, NULL, NULL, NULL),
('60', 'axcal', 'TSTRUCT', '[{"transid":"axcal","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"01/04/2022 15:08:01","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"eventname","x":0,"y":0,"width":20,"height":1,"visibility":true},{"fld_id":"notifiedon","x":20,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"uname","x":0,"y":1,"width":26,"height":1,"visibility":true},{"fld_id":"messagetext","x":0,"y":2,"width":26,"height":3,"visibility":true},{"fld_id":"eventtype","x":0,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"startdate","x":6,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"axptm_starttime","x":12,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"enddate","x":16,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"axptm_endtime","x":22,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"location","x":0,"y":6,"width":16,"height":1,"visibility":true},{"fld_id":"recurring","x":16,"y":6,"width":10,"height":1,"visibility":true},{"fld_id":"emailalert","x":0,"y":7,"width":8,"height":1,"visibility":true},{"fld_id":"statusui","x":8,"y":7,"width":7,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2021-06-05 12:15:52', '2022-04-01 15:13:06', 'N', NULL, NULL, NULL, NULL),
('61', 'temps', 'TSTRUCT', '[{"transid":"temps","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"01/02/2022 06:00:20","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"type","x":0,"y":0,"width":4,"height":1,"visibility":true},{"fld_id":"names","x":4,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"elements","x":0,"y":1,"width":19,"height":1,"visibility":true},{"fld_id":"cvalue","x":0,"y":2,"width":36,"height":7,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', 'N', '2020-03-16 10:57:22', '2022-02-01 06:47:05', 'N', NULL, NULL, NULL, NULL),
('62', 'tconf', 'TSTRUCT', '[{"transid":"tconf","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"tstUpdatedOn":"08/05/2019 12:10:53","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"structname","x":0,"y":0,"width":13,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"searchflds","x":0,"y":0,"width":14,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":42,"visibility":true},{"fld_id":"uniqueThHead2","width":83,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"searchflds","width":352,"visibility":true},{"fld_id":"acondition","width":11,"visibility":true}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"groupbtnname","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"groupbuttons","x":12,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":52,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":true},{"fld_id":"groupbtnname","width":150,"visibility":true},{"fld_id":"groupbuttons","width":400,"visibility":true},{"fld_id":"tmpgp","width":0,"visibility":true},{"fld_id":"tmpgroup","width":0,"visibility":true},{"fld_id":"bcondition","width":0,"visibility":true}]},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"html_buttonname","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"html_filename","x":12,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"html_fields","x":24,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":52,"visibility":true},{"fld_id":"uniqueThHead4","width":40,"visibility":true},{"fld_id":"axp_recid4","width":0,"visibility":true},{"fld_id":"html_buttonname","width":160,"visibility":true},{"fld_id":"html_filename","width":320,"visibility":true},{"fld_id":"html_fields","width":288,"visibility":true},{"fld_id":"t_fields","width":0,"visibility":true},{"fld_id":"t_file","width":0,"visibility":true},{"fld_id":"ccondition","width":0,"visibility":true}]},{"dc_id":"5","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"ref_struct","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"master_field","x":12,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"source_field","x":24,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"ref_idcol","x":0,"y":1,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct5","width":56,"visibility":true},{"fld_id":"uniqueThHead5","width":43,"visibility":true},{"fld_id":"axp_recid5","width":11,"visibility":true},{"fld_id":"ref_struct","width":242,"visibility":true},{"fld_id":"ref_transid","width":11,"visibility":true},{"fld_id":"master_field","width":202,"visibility":true},{"fld_id":"source_field","width":221,"visibility":true},{"fld_id":"ref_idcol","width":160,"visibility":true},{"fld_id":"dcondition","width":11,"visibility":true}]},{"dc_id":"6","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cv_searchflds","x":0,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"cv_groupbuttons","x":7,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"cv_htmlprints","x":14,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"cv_masterflds","x":23,"y":0,"width":10,"height":1,"visibility":true}],"tableDesign":null}]}]', NULL, NULL, 'N', 'N', '2018-12-29 12:10:10', '2019-05-23 11:42:16', 'N', NULL, NULL, NULL, NULL),
('63', 'sendm', 'TSTRUCT', '[{"transid":"sendm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"26/06/2019 19:12:52","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"mtype","x":0,"y":0,"width":10,"height":1,"visibility":true},{"fld_id":"template","x":10,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"keytemplate","x":0,"y":1,"width":27,"height":1,"visibility":true},{"fld_id":"keywords","x":0,"y":2,"width":27,"height":2,"visibility":true},{"fld_id":"msgsubject","x":0,"y":4,"width":27,"height":1,"visibility":true},{"fld_id":"msgcontent","x":0,"y":5,"width":13,"height":2,"visibility":true},{"fld_id":"smsmsg","x":13,"y":5,"width":14,"height":3,"visibility":true}],"tableDesign":null}]}]', 'admin', NULL, 'N', 'N', '2019-08-09 11:21:29', '2019-08-09 11:21:29', 'N', NULL, NULL, NULL, NULL),
('64', 'iconf', 'TSTRUCT', '[{"transid":"iconf","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"tstUpdatedOn":"22/04/2019 12:39:30","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"structname","x":0,"y":0,"width":10,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"groupbtnname","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"groupbuttons","x":6,"y":0,"width":18,"height":1,"visibility":true},{"fld_id":"tmpgp","x":0,"y":1,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":56,"visibility":true},{"fld_id":"uniqueThHead2","width":42,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"groupbtnname","width":207,"visibility":true},{"fld_id":"groupbuttons","width":274,"visibility":true},{"fld_id":"tmpgp","width":240,"visibility":true},{"fld_id":"tmpgroup","width":11,"visibility":true},{"fld_id":"bcondition","width":11,"visibility":true}]},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null}]}]', NULL, NULL, 'N', 'N', '2019-01-05 13:12:49', '2019-05-23 11:40:31', 'N', NULL, NULL, NULL, NULL),
('65', 'dsigc', 'TSTRUCT', '[{"transid":"dsigc","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"26/06/2019 19:11:34","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"transname","x":0,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"tunique","x":13,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"docname","x":0,"y":1,"width":13,"height":1,"visibility":true},{"fld_id":"doctype","x":13,"y":1,"width":7,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"prolename","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"pusername","x":15,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"ordno","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"semail","x":9,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"ssms","x":18,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"axpmailid","x":0,"y":2,"width":18,"height":1,"visibility":true},{"fld_id":"emailid","x":0,"y":3,"width":24,"height":1,"visibility":true},{"fld_id":"mobileno","x":24,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":41,"visibility":true},{"fld_id":"uniqueThHead2","width":41,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"prolename","width":101,"visibility":true},{"fld_id":"pusername","width":94,"visibility":true},{"fld_id":"ordno","width":107,"visibility":true},{"fld_id":"semail","width":153,"visibility":true},{"fld_id":"ssms","width":152,"visibility":true},{"fld_id":"axpmailid","width":100,"visibility":true},{"fld_id":"mailid","width":11,"visibility":true},{"fld_id":"tempemail","width":11,"visibility":true},{"fld_id":"tempmobile","width":11,"visibility":true},{"fld_id":"emailid","width":145,"visibility":true},{"fld_id":"mobileno","width":152,"visibility":true},{"fld_id":"emailflag","width":11,"visibility":true},{"fld_id":"mobileflag","width":11,"visibility":true}]}]}]', 'admin', NULL, 'N', 'N', '2019-08-09 11:16:47', '2019-08-09 11:16:47', 'N', NULL, NULL, NULL, NULL),
('66', 'axfin', 'TSTRUCT', '[{"transid":"axfin","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"19/06/2019 00:00:00","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"ttype","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"finyr","x":9,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"finyridentifier","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"StartDate","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"EndDate","x":9,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"CurrentFinYr","x":18,"y":1,"width":4,"height":1,"visibility":true},{"fld_id":"Closed","x":22,"y":1,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"periodcode","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"perioddesc","x":9,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"quarter","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"pstartdate","x":27,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"penddate","x":0,"y":1,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":150,"visibility":true},{"fld_id":"uniqueThHead2","width":150,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"dfinyr","width":11,"visibility":true},{"fld_id":"periodcode","width":150,"visibility":true},{"fld_id":"perioddesc","width":150,"visibility":true},{"fld_id":"quarter","width":150,"visibility":true},{"fld_id":"pstartdate","width":150,"visibility":true},{"fld_id":"penddate","width":150,"visibility":true},{"fld_id":"days","width":11,"visibility":true},{"fld_id":"blank","width":11,"visibility":true}]}]}]', 'admin', NULL, 'N', 'N', '2019-08-09 11:32:29', '2019-08-09 11:32:29', 'N', NULL, NULL, NULL, NULL),
('68', 'a__ap', 'TSTRUCT', '[{"transid":"a__ap","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/08/2023 11:48:14","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AutoPrintId","x":0,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"form","x":7,"y":0,"width":23,"height":1,"visibility":true},{"fld_id":"formula","x":0,"y":1,"width":30,"height":1,"visibility":true},{"fld_id":"printdoc","x":0,"y":2,"width":30,"height":1,"visibility":true},{"fld_id":"directprint","x":0,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', '', 'N', 'N', '2023-09-27 09:56:17', '2023-09-27 09:56:17', 'N', NULL, NULL, NULL, NULL),
('69', 'ad_lg', 'TSTRUCT', '[{"transid":"ad_lg","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":true,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"26/04/2023 18:03:26","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"20","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"language","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"fontcharset","x":0,"y":1,"width":17,"height":1,"visibility":true},{"fld_id":"fontname","x":0,"y":2,"width":12,"height":1,"visibility":true},{"fld_id":"fontsize","x":12,"y":2,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"exportfiles","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"tstructcap","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"iviewcap","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"btn22","x":0,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"uploadfiletype","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"btn23","x":6,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"btn26","x":12,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"btn24","x":0,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"btn25","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2022-09-06 19:20:51', '2023-04-26 18:03:41', 'N', '', '0', NULL, '0'),
('71', 'axvar', 'TSTRUCT', '[{"transid":"axvar","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"26/09/2022 13:46:56","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"vpname","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"vscript","x":0,"y":1,"width":22,"height":5,"visibility":true},{"fld_id":"pcaption","x":0,"y":6,"width":11,"height":1,"visibility":true},{"fld_id":"pdatatype","x":11,"y":6,"width":6,"height":1,"visibility":true},{"fld_id":"modeofentry","x":17,"y":6,"width":5,"height":1,"visibility":true},{"fld_id":"SQL_editor_psql","x":0,"y":7,"width":22,"height":6,"visibility":true},{"fld_id":"masterdlui","x":0,"y":13,"width":11,"height":1,"visibility":true},{"fld_id":"source","x":11,"y":13,"width":11,"height":1,"visibility":true},{"fld_id":"vpvalue","x":0,"y":14,"width":22,"height":1,"visibility":true},{"fld_id":"display","x":0,"y":15,"width":5,"height":1,"visibility":true},{"fld_id":"readonly","x":5,"y":15,"width":5,"height":1,"visibility":true},{"fld_id":"remarks","x":0,"y":16,"width":22,"height":2,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', 'N', '2021-04-08 15:54:31', '2022-09-26 13:47:28', 'N', NULL, NULL, NULL, NULL),
('72', 'ad_pr', 'TSTRUCT', '[{"transid":"ad_pr","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"22/07/2025 16:28:24","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"smtphost","x":0,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"smtpport","x":0,"y":1,"width":13,"height":1,"visibility":true},{"fld_id":"smtpuser","x":0,"y":2,"width":13,"height":1,"visibility":true},{"fld_id":"smtppwd","x":0,"y":3,"width":13,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"axpsiteno","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"amtinmillions","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"currseperator","x":0,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"lastlogin","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"autogen","x":0,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"customfrom","x":0,"y":5,"width":12,"height":1,"visibility":true},{"fld_id":"customto","x":13,"y":5,"width":11,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"loginattempt","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"pwdencrypt","x":15,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"pwdexp","x":0,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"pwdalphanum","x":15,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"pwdchange","x":0,"y":2,"width":14,"height":1,"visibility":true},{"fld_id":"pwdcapchar","x":15,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"pwdminchar","x":0,"y":3,"width":14,"height":1,"visibility":true},{"fld_id":"pwdsmallchar","x":15,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"pwdmaxchar","x":0,"y":4,"width":14,"height":1,"visibility":true},{"fld_id":"pwdnumchar","x":15,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"pwdreuse","x":0,"y":5,"width":14,"height":1,"visibility":true},{"fld_id":"pwdsplchar","x":15,"y":5,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"otpauth","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"otpchars","x":6,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"otpexpiry","x":13,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"emailsubject","x":0,"y":1,"width":26,"height":1,"visibility":true},{"fld_id":"emailbody","x":0,"y":2,"width":26,"height":4,"visibility":true},{"fld_id":"smscontent","x":0,"y":6,"width":26,"height":4,"visibility":true}],"tableDesign":null},{"dc_id":"5","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"sso_windows","x":0,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_windows","x":6,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"sso_saml","x":0,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_saml","x":6,"y":2,"width":23,"height":1,"visibility":true},{"fld_id":"sso_office365","x":0,"y":3,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_office365","x":6,"y":3,"width":23,"height":1,"visibility":true},{"fld_id":"sso_okta","x":0,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_okta","x":6,"y":4,"width":23,"height":1,"visibility":true},{"fld_id":"sso_google","x":0,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_google","x":6,"y":5,"width":23,"height":1,"visibility":true},{"fld_id":"sso_facebook","x":0,"y":6,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_facebook","x":6,"y":6,"width":23,"height":1,"visibility":true},{"fld_id":"sso_openid","x":0,"y":7,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_openid","x":6,"y":7,"width":23,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'abhinash', 'abhinash', 'N', 'N', '2022-01-10 19:51:44', '2025-07-22 16:29:16', 'N', NULL, NULL, NULL, NULL),
('73', 'a__cd', 'TSTRUCT', '[{"transid":"a__cd","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/08/2025 10:46:22","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cardtype","x":0,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"charttype","x":8,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"cardname","x":0,"y":1,"width":20,"height":1,"visibility":true},{"fld_id":"card_datasource","x":0,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"pluginname","x":0,"y":3,"width":20,"height":1,"visibility":true},{"fld_id":"widthui","x":0,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"heightui","x":7,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"orderno","x":14,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"chartprops","x":0,"y":5,"width":20,"height":1,"visibility":true},{"fld_id":"accessstringui","x":0,"y":6,"width":20,"height":2,"visibility":true},{"fld_id":"inhomepage","x":0,"y":8,"width":6,"height":1,"visibility":true},{"fld_id":"indashboard","x":6,"y":8,"width":6,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2025-01-13 19:20:16', '2025-08-25 10:47:13', 'N', NULL, NULL, NULL, NULL),
('74', 'axurg', 'TSTRUCT', '[{"transid":"axurg","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"24/12/2024 11:52:49","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"pusername","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"usertype","x":0,"y":1,"width":11,"height":1,"visibility":true},{"fld_id":"IsActive","x":11,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"btn17","x":0,"y":2,"width":5,"height":1,"visibility":true},{"fld_id":"btn19","x":0,"y":3,"width":5,"height":1,"visibility":true},{"fld_id":"btn18","x":0,"y":4,"width":5,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2024-09-06 12:01:04', '2025-09-30 13:50:13', 'N', NULL, NULL, NULL, NULL),
('75', 'apidg', 'TSTRUCT', '[{"transid":"apidg","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"18-11-2025 12:18:51","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"ExecAPIDefName","x":0,"y":0,"width":28,"height":1,"visibility":true},{"fld_id":"APItype","x":0,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"ExecAPIMethod","x":14,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"APIResponseFormat","x":19,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"btn17","x":24,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"config_url_name","x":0,"y":2,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIURL","x":0,"y":3,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIParameterString","x":0,"y":4,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIHeaderString","x":0,"y":5,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIbodyparamstring","x":0,"y":7,"width":28,"height":2,"visibility":true},{"fld_id":"ExecAPIRequestString","x":0,"y":9,"width":28,"height":5,"visibility":true},{"fld_id":"APIResponseString","x":0,"y":14,"width":28,"height":6,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"ExecAPIBasedOn","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"ExecAPIform","x":0,"y":1,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIFilterString","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIlPrintFormNames","x":0,"y":3,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIFormAttachments","x":0,"y":4,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIIVIew","x":0,"y":5,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIIParams","x":0,"y":6,"width":24,"height":1,"visibility":true},{"fld_id":"SQL_editor_ExecAPISQLText","x":0,"y":7,"width":24,"height":7,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2021-04-03 14:22:20', '2025-11-18 12:21:07', 'N', NULL, NULL, NULL, NULL),
('77', 'ctype', 'TSTRUCT', '[{"transid":"ctype","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"28-11-2025 12:10:29","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"typename","x":0,"y":0,"width":10,"height":1,"visibility":true},{"fld_id":"isspldatatpye","x":10,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"datatype","x":0,"y":1,"width":10,"height":1,"visibility":true},{"fld_id":"spldatatype","x":0,"y":2,"width":10,"height":1,"visibility":true},{"fld_id":"width","x":0,"y":3,"width":5,"height":1,"visibility":true},{"fld_id":"dwidth","x":5,"y":3,"width":5,"height":1,"visibility":true},{"fld_id":"isactive","x":0,"y":4,"width":5,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2021-08-03 17:01:24', '2025-11-28 12:11:32', 'N', NULL, NULL, NULL, NULL),
('33', 'a__pn', 'TSTRUCT', '[{"transid":"a__pn","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"21/06/2024 11:25:14","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"name","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"startdate","x":14,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"starttime","x":21,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"frequency","x":0,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"sendday","x":7,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"sendon","x":14,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"sendtime","x":21,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"datasource","x":0,"y":2,"width":7,"height":1,"visibility":true},{"fld_id":"messagetitle","x":7,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"MessageText","x":0,"y":3,"width":27,"height":3,"visibility":true},{"fld_id":"messageattsingle","x":0,"y":6,"width":12,"height":1,"visibility":true},{"fld_id":"messageattachmentsui","x":12,"y":6,"width":15,"height":2,"visibility":true},{"fld_id":"fromuserui","x":0,"y":8,"width":12,"height":1,"visibility":true},{"fld_id":"notifyto","x":12,"y":8,"width":15,"height":2,"visibility":true},{"fld_id":"usergroups","x":0,"y":10,"width":27,"height":2,"visibility":true},{"fld_id":"usernames","x":0,"y":12,"width":27,"height":2,"visibility":true},{"fld_id":"externalemails","x":0,"y":14,"width":27,"height":1,"visibility":true},{"fld_id":"mobilenotify","x":0,"y":15,"width":7,"height":1,"visibility":true},{"fld_id":"active","x":7,"y":15,"width":7,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"navigateto","x":0,"y":0,"width":23,"height":1,"visibility":true},{"fld_id":"loadopen","x":23,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"tbl_navigationparam","x":0,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"formula","x":0,"y":2,"width":23,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2023-08-03 15:45:06', '2024-06-21 11:32:44', 'N', '', '0', NULL, '0'),
('76', 'a__ua', 'TSTRUCT', '[{"transid":"a__ua","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"07/02/2026 17:05:25","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"pusername","x":0,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"adminaccess","x":11,"y":0,"width":14,"height":2,"visibility":true},{"fld_id":"usergroups","x":0,"y":2,"width":25,"height":2,"visibility":true},{"fld_id":"mobile","x":0,"y":6,"width":11,"height":1,"visibility":true},{"fld_id":"email","x":11,"y":6,"width":14,"height":1,"visibility":true},{"fld_id":"pwdauth","x":0,"y":7,"width":6,"height":1,"visibility":true},{"fld_id":"otpauth","x":6,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"portaluser","x":11,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"staysignedin","x":16,"y":7,"width":4,"height":1,"visibility":true},{"fld_id":"signinexpiry","x":20,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"actflag","x":0,"y":8,"width":6,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"axusergroup","x":15,"y":1,"width":12,"height":1,"visibility":true},{"fld_id":"startdate","x":27,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"enddate","x":0,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":150,"visibility":true},{"fld_id":"uniqueThHead2","width":150,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"axusername","width":0,"visibility":false},{"fld_id":"axusergroup","width":240,"visibility":true},{"fld_id":"startdate","width":150,"visibility":true},{"fld_id":"enddate","width":150,"visibility":true},{"fld_id":"validrow2","width":0,"visibility":false}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"axuserrole","x":0,"y":0,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":20,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"axuserrole","width":294,"visibility":true},{"fld_id":"sqltext","width":0,"visibility":false},{"fld_id":"cnd","width":0,"visibility":false}]},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2024-11-27 14:16:15', '2026-02-07 17:07:53', 'N', '', '0', NULL, '0'),
('38', 'job_s', 'TSTRUCT', '[{"transid":"job_s","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"03-03-2026 17:01:07","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"jobid","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"jname","x":6,"y":0,"width":19,"height":1,"visibility":true},{"fld_id":"priority","x":25,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"exp_editor_jobscript","x":0,"y":1,"width":31,"height":4,"visibility":true},{"fld_id":"jobschedule","x":0,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"weekday","x":6,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"jobstartfrom","x":12,"y":5,"width":7,"height":1,"visibility":true},{"fld_id":"axptm_starttime","x":19,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"jday","x":25,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"noofmins","x":31,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"Remarks","x":0,"y":6,"width":31,"height":1,"visibility":true},{"fld_id":"deletepending","x":0,"y":7,"width":6,"height":1,"visibility":true},{"fld_id":"isactive","x":6,"y":7,"width":4,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2021-02-23 14:16:50', '2026-03-03 17:28:17', 'N', '', '0', NULL, '0'),
('29', 'a__ag', 'TSTRUCT', '[{"transid":"a__ag","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"20/02/2026 10:29:32","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"grpname","x":0,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"parentgrp","x":7,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"grpvalue","x":0,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"grpparent","x":0,"y":2,"width":16,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2025-04-16 00:58:51', '2026-02-20 10:29:56', 'N', '', '0', NULL, '0'),
('70', 'a__up', 'TSTRUCT', '[{"transid":"a__up","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"09/03/2026 16:46:47","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"axuserrole","x":0,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"axusername","x":8,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"comptype","x":16,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"formcap","x":0,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"allowcreate","x":16,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"viewcnd","x":0,"y":2,"width":22,"height":1,"visibility":true},{"fld_id":"view_flds","x":0,"y":3,"width":22,"height":2,"visibility":true},{"fld_id":"editcnd","x":0,"y":5,"width":22,"height":1,"visibility":true},{"fld_id":"edit_flds","x":0,"y":6,"width":22,"height":2,"visibility":true},{"fld_id":"fieldmasks","x":0,"y":8,"width":22,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2025-03-24 15:45:38', '2026-03-09 16:55:44', 'N', '', '0', NULL, '0'),
('22', 'a_pgm', 'TSTRUCT', '[{"transid":"a_pgm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"20/02/2026 10:21:19","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"grpname","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"grpcaption","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"parentgrp","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2025-04-17 18:29:11', '2026-02-20 10:25:23', 'N', '', '0', NULL, '0'),
('78', 'a_pgt', 'TSTRUCT', '[{"transid":"a_pgt","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":null,"selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"14/04/2025 06:45:07","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcap","x":0,"y":0,"width":15,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', 'N', '2025-04-16 00:58:23', '2025-04-16 00:58:23', 'N', NULL, '0', NULL, '0'),
('44', 'b_sql', 'TSTRUCT', '[{"transid":"b_sql","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"04/02/2026 17:45:57","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"sqlname","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"sqlsrc","x":21,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"adsdesc","x":0,"y":1,"width":28,"height":2,"visibility":true},{"fld_id":"sqltext","x":0,"y":3,"width":28,"height":6,"visibility":true},{"fld_id":"sqlparams","x":0,"y":9,"width":28,"height":1,"visibility":true},{"fld_id":"sqlquerycols","x":0,"y":10,"width":28,"height":1,"visibility":true},{"fld_id":"encryptedflds","x":0,"y":11,"width":28,"height":1,"visibility":true},{"fld_id":"smartlistcnd","x":0,"y":12,"width":28,"height":2,"visibility":true},{"fld_id":"cachedata","x":0,"y":14,"width":5,"height":1,"visibility":true},{"fld_id":"cacheinterval","x":5,"y":14,"width":7,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"fldname","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"fldcaption","x":0,"y":1,"width":24,"height":1,"visibility":true},{"fld_id":"sourcetable","x":0,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"sourcefld","x":15,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"hyp_structtype","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"hyp_struct","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"tbl_hyperlink","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"datatypeui","x":0,"y":6,"width":9,"height":1,"visibility":true},{"fld_id":"filter","x":9,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":44,"visibility":true},{"fld_id":"uniqueThHead2","width":47,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"fldname","width":235,"visibility":true},{"fld_id":"fldcaption","width":286,"visibility":true},{"fld_id":"datatypeui","width":152,"visibility":true},{"fld_id":"fdatatype","width":0,"visibility":false},{"fld_id":"filter","width":105,"visibility":true},{"fld_id":"sourcetable","width":242,"visibility":true},{"fld_id":"sourcefld","width":222,"visibility":true},{"fld_id":"normalized","width":0,"visibility":false},{"fld_id":"hyp_structtype","width":113,"visibility":true},{"fld_id":"hyp_stype","width":0,"visibility":false},{"fld_id":"hyp_struct","width":422,"visibility":true},{"fld_id":"hyp_transid","width":0,"visibility":false},{"fld_id":"hyp_structsource","width":0,"visibility":false},{"fld_id":"hyp_target","width":0,"visibility":false},{"fld_id":"tbl_hyperlink","width":400,"visibility":true}]}],"newdcs":null}]', 'admin', 'admin', 'N', 'N', '2021-01-19 16:07:14', '2026-02-04 18:04:55', 'N', '', '0', NULL, '0')
ON CONFLICT DO NOTHING;

-- Seed: ax_layoutdesign_saved (60 rows)
INSERT INTO {schema}.ax_layoutdesign_saved (design_id, transid, module, content, created_by, updated_by, is_deleted, created_on, updated_on, is_migrated, is_publish, is_private, parent_design_id, responsibility, order_by)
VALUES
('19', 'ad_db', 'TSTRUCT', '[{"transid":"ad_db","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"09/11/2022 18:54:52","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"db_function","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"db_function_params","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"event_onlogin","x":0,"y":2,"width":4,"height":1,"visibility":true},{"fld_id":"event_onformload","x":0,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"forms","x":4,"y":3,"width":32,"height":1,"visibility":true},{"fld_id":"event_onreportload","x":0,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"reports","x":4,"y":4,"width":32,"height":1,"visibility":true},{"fld_id":"remarks","x":0,"y":5,"width":36,"height":2,"visibility":true},{"fld_id":"btn18","x":13,"y":7,"width":3,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"db_varname","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"db_varval","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"db_vartype","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"db_varcaption","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":0,"visibility":false},{"fld_id":"uniqueThHead2","width":65,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"db_varname","width":328,"visibility":true},{"fld_id":"db_varcaption","width":366,"visibility":true},{"fld_id":"db_varval","width":312,"visibility":true},{"fld_id":"db_vartype","width":93,"visibility":true}]}]}]', 'admin', 'admin', 'N', '2022-09-20 11:27:12', '2022-12-12 04:20:03', 'N', 'Y', 'N', '75', NULL, '0'),
('20', 'axusr', 'TSTRUCT', '[{"transid":"axusr","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"selectedLayout":"single","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"06/02/2026 12:20:24","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"pusername","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"nickname","x":9,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"pwd","x":21,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"profilepic","x":29,"y":0,"width":5,"height":3,"visibility":true},{"fld_id":"email","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"mobile","x":9,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"dhomepage","x":16,"y":1,"width":13,"height":1,"visibility":true},{"fld_id":"axlang","x":0,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"global_displaytext","x":9,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"appmanager","x":0,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"importstruct","x":5,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"exportstruct","x":9,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"build","x":13,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"portaluser","x":17,"y":3,"width":4,"height":1,"visibility":true},{"fld_id":"isuniquehybrid","x":21,"y":3,"width":8,"height":1,"visibility":true},{"fld_id":"pwdauth","x":0,"y":4,"width":5,"height":1,"visibility":true},{"fld_id":"otpauth","x":5,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"actflag","x":9,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"staysignedin","x":13,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"signinexpiry","x":17,"y":4,"width":4,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"axusergroup","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"startdate","x":12,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"enddate","x":21,"y":0,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":28,"visibility":true},{"fld_id":"uniqueThHead2","width":40,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"axusername","width":0,"visibility":false},{"fld_id":"axusergroup","width":249,"visibility":true},{"fld_id":"startdate","width":155,"visibility":true},{"fld_id":"enddate","width":155,"visibility":true},{"fld_id":"validrow2","width":0,"visibility":false}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"charts","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"graphtype","x":24,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":20,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"charts","width":331,"visibility":true},{"fld_id":"chartgroup","width":0,"visibility":false},{"fld_id":"graphtypeflag","width":0,"visibility":false},{"fld_id":"tmp_graphtype","width":0,"visibility":false},{"fld_id":"graphtype","width":322,"visibility":true},{"fld_id":"piecolor","width":0,"visibility":false},{"fld_id":"titlelinkname","width":0,"visibility":false},{"fld_id":"filterlinkname","width":0,"visibility":false},{"fld_id":"sqltext","width":0,"visibility":false},{"fld_id":"hyptext","width":0,"visibility":false}]}],"newdcs":null}]', 'admin', 'admin', 'N', '2019-08-06 16:31:24', '2026-02-07 18:07:00', 'N', 'Y', 'N', '73', NULL, '0'),
('21', 'axstc', 'TSTRUCT', '[{"transid":"axstc","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"09/06/2023 19:11:29","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"asprops","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"descp","x":0,"y":1,"width":26,"height":3,"visibility":true},{"fld_id":"propvalue1","x":0,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"propvalue2","x":7,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"structcaption","x":14,"y":4,"width":12,"height":1,"visibility":true},{"fld_id":"uploadfiletype","x":0,"y":5,"width":26,"height":2,"visibility":true},{"fld_id":"structelements1","x":0,"y":7,"width":26,"height":3,"visibility":true},{"fld_id":"structelements","x":0,"y":10,"width":7,"height":1,"visibility":true},{"fld_id":"etype","x":7,"y":10,"width":7,"height":1,"visibility":true},{"fld_id":"userroles","x":14,"y":10,"width":7,"height":1,"visibility":true},{"fld_id":"purpose","x":0,"y":11,"width":26,"height":2,"visibility":true}],"tableDesign":null}]}]', 'pandi', 'admin', 'N', '2019-04-03 18:38:18', '2023-06-09 06:45:21', 'N', 'Y', 'N', '12', NULL, '0'),
('23', 'a__iq', 'TSTRUCT', '[{"transid":"a__iq","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"14/12/2023 22:08:05","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxQueueName","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"AxQueueDesc","x":0,"y":1,"width":24,"height":2,"visibility":true},{"fld_id":"unameui","x":0,"y":3,"width":14,"height":1,"visibility":true},{"fld_id":"secretkey","x":14,"y":3,"width":10,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":5,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-09-27 09:45:21', '2023-12-14 22:08:57', 'N', 'Y', 'N', '80', NULL, '0'),
('24', 'pgv2m', 'TSTRUCT', '[{"transid":"pgv2m","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"26/09/2023 16:18:19","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcaption","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"KeyFieldcaption","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"taskgroupname","x":0,"y":2,"width":11,"height":1,"visibility":true},{"fld_id":"TaskName","x":11,"y":2,"width":25,"height":1,"visibility":true},{"fld_id":"assignto","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"assigntoactor","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"AssignToRole","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"useridentificationfilter","x":0,"y":6,"width":31,"height":2,"visibility":true},{"fld_id":"useridentificationfilter_of","x":31,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"formfieldscaption","x":0,"y":8,"width":36,"height":1,"visibility":true},{"fld_id":"skipleveluser","x":0,"y":9,"width":36,"height":1,"visibility":true},{"fld_id":"IndexNo","x":0,"y":10,"width":6,"height":1,"visibility":true},{"fld_id":"ParentTaskName","x":6,"y":10,"width":30,"height":1,"visibility":true},{"fld_id":"applicability_tbl","x":0,"y":11,"width":36,"height":1,"visibility":true},{"fld_id":"groupwithprior","x":0,"y":14,"width":6,"height":1,"visibility":true},{"fld_id":"isoptional","x":6,"y":14,"width":6,"height":1,"visibility":true},{"fld_id":"usebusinessdatelogic","x":12,"y":14,"width":16,"height":1,"visibility":true},{"fld_id":"active","x":28,"y":14,"width":8,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"dummy","x":0,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"DisplayTitle","x":0,"y":0,"width":31,"height":1,"visibility":true},{"fld_id":"DisplayIcon","x":31,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"DIsplayContent","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"displaymcontent","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"TimelineTitle","x":0,"y":5,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cmd","x":0,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"tbldtls","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":41,"visibility":true},{"fld_id":"uniqueThHead4","width":57,"visibility":true},{"fld_id":"axp_recid4","width":0,"visibility":false},{"fld_id":"cmd","width":176,"visibility":true},{"fld_id":"pcnd","width":0,"visibility":false},{"fld_id":"cmdtmp","width":0,"visibility":false},{"fld_id":"setvalueflds","width":0,"visibility":false},{"fld_id":"tbldtls","width":293,"visibility":true},{"fld_id":"axpscript","width":0,"visibility":false},{"fld_id":"axscripttmp","width":0,"visibility":false},{"fld_id":"formctlcnt","width":0,"visibility":false}]},{"dc_id":"5","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"remindnotify","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"rem_startfrom","x":0,"y":13,"width":36,"height":1,"visibility":true},{"fld_id":"rem_when","x":0,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_maildays","x":9,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_mailndays","x":18,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_daytypeui","x":0,"y":15,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct5","width":40,"visibility":true},{"fld_id":"uniqueThHead5","width":47,"visibility":true},{"fld_id":"axp_recid5","width":0,"visibility":false},{"fld_id":"remindafter","width":0,"visibility":false},{"fld_id":"remindday","width":0,"visibility":false},{"fld_id":"reminderhr","width":0,"visibility":false},{"fld_id":"remindmin","width":0,"visibility":false},{"fld_id":"rem_startfrom","width":289,"visibility":true},{"fld_id":"oldrem_startfrom","width":0,"visibility":false},{"fld_id":"remindercnt","width":0,"visibility":false},{"fld_id":"rem_startafter","width":0,"visibility":false},{"fld_id":"rem_when","width":90,"visibility":true},{"fld_id":"rem_maildays","width":103,"visibility":true},{"fld_id":"rem_mailndays","width":147,"visibility":true},{"fld_id":"rem_daytypeui","width":180,"visibility":true},{"fld_id":"rem_daytype","width":155,"visibility":false},{"fld_id":"rem_startfromcnd","width":0,"visibility":false},{"fld_id":"rem_startfromfname","width":0,"visibility":false},{"fld_id":"rem_frequency","width":0,"visibility":false},{"fld_id":"rem_frq_daytype","width":0,"visibility":false},{"fld_id":"remindnotify","width":503,"visibility":true},{"fld_id":"rem_stopafter","width":0,"visibility":false},{"fld_id":"rem_taskparamsui","width":0,"visibility":false}]},{"dc_id":"6","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"escalate","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"escalatetoactor","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"escalatetemplate","x":0,"y":5,"width":24,"height":1,"visibility":true},{"fld_id":"escalate_notifyto","x":0,"y":20,"width":15,"height":1,"visibility":true},{"fld_id":"notifytoactor","x":0,"y":21,"width":36,"height":1,"visibility":true},{"fld_id":"esc_startfrom","x":0,"y":22,"width":36,"height":1,"visibility":true},{"fld_id":"esc_when","x":0,"y":23,"width":9,"height":1,"visibility":true},{"fld_id":"esc_maildays","x":9,"y":23,"width":9,"height":1,"visibility":true},{"fld_id":"esc_mailndays","x":18,"y":23,"width":9,"height":1,"visibility":true},{"fld_id":"esc_daytypeui","x":0,"y":24,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct6","width":40,"visibility":true},{"fld_id":"uniqueThHead6","width":56,"visibility":true},{"fld_id":"axp_recid6","width":0,"visibility":false},{"fld_id":"escalateafter","width":0,"visibility":false},{"fld_id":"escalateday","width":0,"visibility":false},{"fld_id":"escalatehr","width":0,"visibility":false},{"fld_id":"escalatemin","width":0,"visibility":false},{"fld_id":"esc_startfrom","width":347,"visibility":true},{"fld_id":"oldesc_startfrom","width":0,"visibility":false},{"fld_id":"esc_when","width":85,"visibility":true},{"fld_id":"esc_maildays","width":105,"visibility":true},{"fld_id":"esc_mailndays","width":171,"visibility":true},{"fld_id":"esc_daytypeui","width":171,"visibility":true},{"fld_id":"esc_daytype","width":125,"visibility":false},{"fld_id":"escalationcnt","width":0,"visibility":false},{"fld_id":"esc_startfromcnd","width":0,"visibility":false},{"fld_id":"esc_startfromfname","width":0,"visibility":false},{"fld_id":"esc_frequency","width":0,"visibility":false},{"fld_id":"esc_frq_daytype","width":0,"visibility":false},{"fld_id":"escalate","width":296,"visibility":true},{"fld_id":"escalatetoactor","width":332,"visibility":true},{"fld_id":"escalatetemplate","width":332,"visibility":true},{"fld_id":"escalateflg","width":0,"visibility":false},{"fld_id":"escalate_notifyto","width":221,"visibility":true},{"fld_id":"notifytoactor","width":290,"visibility":true},{"fld_id":"esc_taskparamsui","width":0,"visibility":false}]},{"dc_id":"7","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"taskparamsui","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"TaskNotification","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"taskdescription","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"hidecards","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"allowedit","x":0,"y":7,"width":9,"height":1,"visibility":true},{"fld_id":"allowedittasks","x":0,"y":8,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"8","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cardname","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"cardtype","x":0,"y":1,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct8","width":83,"visibility":true},{"fld_id":"uniqueThHead8","width":66,"visibility":true},{"fld_id":"axp_recid8","width":0,"visibility":false},{"fld_id":"cardname","width":435,"visibility":true},{"fld_id":"cardtype","width":201,"visibility":true}]}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-02-24 09:59:54', '2023-09-26 16:19:38', 'N', 'Y', 'N', '64', NULL, '0'),
('25', 'pgv2a', 'TSTRUCT', '[{"transid":"pgv2a","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"23/09/2024 11:01:00","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcaption","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"KeyFieldcaption","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"taskgroupname","x":0,"y":2,"width":10,"height":1,"visibility":true},{"fld_id":"TaskName","x":10,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"autoapprove","x":30,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"assignto","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"assigntoactor","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"AssignToRole","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"formfieldscaption","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"skipleveluser","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"useridentificationfilter","x":0,"y":8,"width":31,"height":2,"visibility":true},{"fld_id":"useridentificationfilter_of","x":31,"y":8,"width":5,"height":1,"visibility":true},{"fld_id":"allowsend","x":0,"y":10,"width":36,"height":1,"visibility":true},{"fld_id":"senduser_in","x":0,"y":11,"width":36,"height":2,"visibility":true},{"fld_id":"senduser_notin","x":0,"y":13,"width":36,"height":2,"visibility":true},{"fld_id":"sendtoactor","x":0,"y":15,"width":36,"height":2,"visibility":true},{"fld_id":"IndexNo","x":0,"y":17,"width":7,"height":1,"visibility":true},{"fld_id":"ParentTaskName","x":7,"y":17,"width":29,"height":1,"visibility":true},{"fld_id":"groupwithprior","x":0,"y":18,"width":7,"height":1,"visibility":true},{"fld_id":"approve_forwardto","x":7,"y":18,"width":9,"height":1,"visibility":true},{"fld_id":"initiator_approval","x":16,"y":18,"width":9,"height":1,"visibility":true},{"fld_id":"orphan_autoapproval","x":25,"y":18,"width":11,"height":1,"visibility":true},{"fld_id":"returnable","x":0,"y":19,"width":7,"height":1,"visibility":true},{"fld_id":"return_to_priorindex","x":7,"y":19,"width":9,"height":1,"visibility":true},{"fld_id":"usebusinessdatelogic","x":16,"y":19,"width":11,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":20,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"10","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"PostNotify","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"PostNotify_return","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"PostNotify_reject","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"TaskNotification","x":0,"y":6,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"11","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cmsg_appcheck","x":0,"y":0,"width":29,"height":2,"visibility":true},{"fld_id":"cmsg_return","x":0,"y":2,"width":29,"height":2,"visibility":true},{"fld_id":"cmsg_reject","x":0,"y":4,"width":29,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"DisplayTitle","x":0,"y":0,"width":22,"height":1,"visibility":true},{"fld_id":"DisplayIcon","x":22,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"showbuttons","x":28,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"DIsplayContent","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"displaymcontent","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"TimelineTitle","x":0,"y":5,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cmd","x":0,"y":3,"width":12,"height":1,"visibility":true},{"fld_id":"tbldtls","x":0,"y":4,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":40,"visibility":true},{"fld_id":"uniqueThHead4","width":64,"visibility":true},{"fld_id":"axp_recid4","width":0,"visibility":false},{"fld_id":"cmd","width":248,"visibility":true},{"fld_id":"pcnd","width":0,"visibility":false},{"fld_id":"cmdtmp","width":0,"visibility":false},{"fld_id":"fctlfldcaption","width":0,"visibility":false},{"fld_id":"tbldtls","width":838,"visibility":true},{"fld_id":"axpscript","width":0,"visibility":false},{"fld_id":"axscripttmp","width":0,"visibility":false},{"fld_id":"setvalueflds","width":0,"visibility":false},{"fld_id":"formctlcnt","width":0,"visibility":false}]},{"dc_id":"5","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"setval_formcaption","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"tblsetval","x":0,"y":1,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct5","width":43,"visibility":true},{"fld_id":"uniqueThHead5","width":59,"visibility":true},{"fld_id":"axp_recid5","width":0,"visibility":false},{"fld_id":"setval_formcaption","width":570,"visibility":true},{"fld_id":"setval_formname","width":0,"visibility":false},{"fld_id":"setval_fldcap","width":0,"visibility":false},{"fld_id":"setval_fldname","width":0,"visibility":false},{"fld_id":"tblsetval","width":789,"visibility":true},{"fld_id":"setvalscr","width":0,"visibility":false},{"fld_id":"rulesetvalscr","width":0,"visibility":false}]},{"dc_id":"6","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"remindnotify","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"rem_startfrom","x":0,"y":13,"width":36,"height":1,"visibility":true},{"fld_id":"rem_when","x":0,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_maildays","x":9,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_mailndays","x":18,"y":14,"width":9,"height":1,"visibility":true},{"fld_id":"rem_daytypeui","x":0,"y":15,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct6","width":40,"visibility":true},{"fld_id":"uniqueThHead6","width":46,"visibility":true},{"fld_id":"axp_recid6","width":0,"visibility":false},{"fld_id":"remindafter","width":0,"visibility":false},{"fld_id":"remindday","width":0,"visibility":false},{"fld_id":"reminderhr","width":0,"visibility":false},{"fld_id":"remindmin","width":0,"visibility":false},{"fld_id":"rem_startfrom","width":288,"visibility":true},{"fld_id":"oldrem_startfrom","width":0,"visibility":false},{"fld_id":"rem_when","width":82,"visibility":true},{"fld_id":"rem_maildays","width":98,"visibility":true},{"fld_id":"rem_mailndays","width":158,"visibility":true},{"fld_id":"rem_daytypeui","width":198,"visibility":true},{"fld_id":"rem_daytype","width":0,"visibility":false},{"fld_id":"remindercnt","width":0,"visibility":false},{"fld_id":"rem_startafter","width":0,"visibility":false},{"fld_id":"rem_startfromcnd","width":0,"visibility":false},{"fld_id":"rem_startfromfname","width":0,"visibility":false},{"fld_id":"rem_frequency","width":0,"visibility":false},{"fld_id":"rem_frq_daytype","width":0,"visibility":false},{"fld_id":"remindnotify","width":501,"visibility":true},{"fld_id":"rem_stopafter","width":0,"visibility":false},{"fld_id":"rem_taskparamsui","width":0,"visibility":false}]},{"dc_id":"7","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"escalate","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"escalatetoactor","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"escalatetemplate","x":0,"y":5,"width":24,"height":1,"visibility":true},{"fld_id":"escalate_notifyto","x":0,"y":17,"width":15,"height":1,"visibility":true},{"fld_id":"notifytoactor","x":0,"y":18,"width":36,"height":1,"visibility":true},{"fld_id":"esc_startfrom","x":0,"y":19,"width":36,"height":1,"visibility":true},{"fld_id":"esc_when","x":0,"y":20,"width":9,"height":1,"visibility":true},{"fld_id":"esc_maildays","x":9,"y":20,"width":9,"height":1,"visibility":true},{"fld_id":"esc_mailndays","x":18,"y":20,"width":9,"height":1,"visibility":true},{"fld_id":"esc_daytypeui","x":0,"y":21,"width":15,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct7","width":43,"visibility":true},{"fld_id":"uniqueThHead7","width":40,"visibility":true},{"fld_id":"axp_recid7","width":0,"visibility":false},{"fld_id":"escalateafter","width":0,"visibility":false},{"fld_id":"esc_startfrom","width":306,"visibility":true},{"fld_id":"esc_when","width":77,"visibility":true},{"fld_id":"esc_maildays","width":94,"visibility":true},{"fld_id":"esc_mailndays","width":175,"visibility":true},{"fld_id":"esc_daytypeui","width":171,"visibility":true},{"fld_id":"esc_daytype","width":0,"visibility":false},{"fld_id":"esc_startfromfname","width":0,"visibility":false},{"fld_id":"esc_startfromcnd","width":0,"visibility":false},{"fld_id":"esc_frequency","width":0,"visibility":false},{"fld_id":"esc_frq_daytype","width":0,"visibility":false},{"fld_id":"escalateday","width":0,"visibility":false},{"fld_id":"escalatehr","width":0,"visibility":false},{"fld_id":"escalatemin","width":0,"visibility":false},{"fld_id":"escalate","width":271,"visibility":true},{"fld_id":"escalateflg","width":0,"visibility":false},{"fld_id":"escalatetoactor","width":303,"visibility":true},{"fld_id":"escalatetemplate","width":318,"visibility":true},{"fld_id":"escalate_notifyto","width":224,"visibility":true},{"fld_id":"notifytoactor","width":256,"visibility":true},{"fld_id":"oldesc_startfrom","width":0,"visibility":false},{"fld_id":"esc_taskparamsui","width":0,"visibility":false}]},{"dc_id":"8","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"taskparamsui","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"taskdescription","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"hidecards","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"allowedit","x":0,"y":5,"width":9,"height":1,"visibility":true},{"fld_id":"allowedittasks","x":0,"y":6,"width":36,"height":2,"visibility":true}],"tableDesign":null},{"dc_id":"9","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"approvecmt","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"returncmt","x":9,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"rejectcmt","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"approvereasons","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"defapptext","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"returnreasons","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"defrettext","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"RejectReasons","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"defregtext","x":0,"y":6,"width":36,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-02-24 20:28:27', '2024-09-23 11:02:54', 'N', 'Y', 'N', '66', NULL, '0'),
('26', 'ad_ur', 'TSTRUCT', '[{"transid":"ad_ur","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"27/11/2024 17:50:04","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"axusergroup","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"btn17","x":15,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"dhomepage","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"useprodform","x":15,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', '', 'N', '2024-12-13 08:24:16', '2024-12-13 08:24:16', 'N', 'Y', 'N', '114', NULL, '0'),
('27', 'ad_pn', 'TSTRUCT', '[{"transid":"ad_pn","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"29/05/2023 19:36:25","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"name","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"processname","x":9,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"taskname","x":23,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"NotifyTo","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"fromfieldcaption","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"roles","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"actors","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"taskparams","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"tasklist","x":0,"y":8,"width":36,"height":1,"visibility":true},{"fld_id":"emailaddr","x":0,"y":9,"width":36,"height":1,"visibility":true},{"fld_id":"EnableEmail","x":0,"y":10,"width":9,"height":1,"visibility":true},{"fld_id":"EnableSMS","x":9,"y":10,"width":9,"height":1,"visibility":true},{"fld_id":"EnableWhatsapp","x":18,"y":10,"width":9,"height":1,"visibility":true},{"fld_id":"enablemobilenotify","x":27,"y":10,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"emailsubject","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"emailattachment","x":0,"y":1,"width":36,"height":2,"visibility":true},{"fld_id":"EmailText","x":0,"y":3,"width":36,"height":7,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notifyto_cc","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"fromfieldcaption_cc","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"roles_cc","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"actors_cc","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"taskparams_cc","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"tasklist_cc","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"emailaddr_cc","x":0,"y":8,"width":36,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notifyto_bcc","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"fromfieldcaption_bcc","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"roles_bcc","x":0,"y":3,"width":36,"height":2,"visibility":true},{"fld_id":"actors_bcc","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"taskparams_bcc","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"tasklist_bcc","x":0,"y":7,"width":36,"height":1,"visibility":true},{"fld_id":"emailaddr_bcc","x":0,"y":8,"width":36,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"5","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"SMStext","x":0,"y":0,"width":36,"height":4,"visibility":true}],"tableDesign":null},{"dc_id":"6","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"WhatsApptext","x":0,"y":0,"width":36,"height":4,"visibility":true}],"tableDesign":null},{"dc_id":"7","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"mobile_title","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"mobile_content","x":0,"y":1,"width":36,"height":3,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2022-11-07 12:32:12', '2023-05-29 19:36:39', 'N', 'Y', 'N', '49', NULL, '0'),
('28', 'a__fn', 'TSTRUCT', '[{"transid":"a__fn","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"29/07/2024 17:54:16","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"form","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"formula","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notifyto","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"usergroups","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"usernames","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"formfield","x":0,"y":6,"width":36,"height":1,"visibility":true},{"fld_id":"whatsapp_usernames","x":0,"y":7,"width":21,"height":2,"visibility":true},{"fld_id":"whatsapp_formfield","x":21,"y":7,"width":15,"height":1,"visibility":true},{"fld_id":"sms_usernames","x":0,"y":9,"width":21,"height":2,"visibility":true},{"fld_id":"sms_formfield","x":21,"y":9,"width":15,"height":1,"visibility":true},{"fld_id":"isemailreq","x":0,"y":11,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"notify_msg_prints","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"notify_sub_new","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_new","x":0,"y":2,"width":36,"height":3,"visibility":true},{"fld_id":"notify_sub_edit","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_edit","x":0,"y":6,"width":36,"height":3,"visibility":true},{"fld_id":"notify_sub_cancel","x":0,"y":9,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_cancel","x":0,"y":10,"width":36,"height":3,"visibility":true},{"fld_id":"notify_sub_delete","x":0,"y":13,"width":36,"height":1,"visibility":true},{"fld_id":"notify_msg_delete","x":0,"y":14,"width":36,"height":3,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"emailto","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"emailto_usernames","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"emailto_usergroups","x":0,"y":4,"width":17,"height":2,"visibility":true},{"fld_id":"emailto_formfield","x":17,"y":4,"width":19,"height":1,"visibility":true},{"fld_id":"emailcc","x":0,"y":6,"width":36,"height":2,"visibility":true},{"fld_id":"emailcc_usernames","x":0,"y":8,"width":36,"height":2,"visibility":true},{"fld_id":"emailcc_usergroups","x":0,"y":10,"width":17,"height":2,"visibility":true},{"fld_id":"emailcc_formfield","x":17,"y":10,"width":19,"height":1,"visibility":true},{"fld_id":"emailbcc","x":0,"y":12,"width":36,"height":2,"visibility":true},{"fld_id":"emailbcc_usernames","x":0,"y":14,"width":36,"height":2,"visibility":true},{"fld_id":"emailbcc_usergroups","x":0,"y":16,"width":17,"height":2,"visibility":true},{"fld_id":"emailbcc_formfield","x":17,"y":16,"width":19,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"5","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"email_msg_prints","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"email_msg_attachmentsui","x":0,"y":2,"width":36,"height":1,"visibility":true},{"fld_id":"email_sub_new","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_new","x":0,"y":6,"width":36,"height":5,"visibility":true},{"fld_id":"email_sub_edit","x":0,"y":11,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_edit","x":0,"y":12,"width":36,"height":5,"visibility":true},{"fld_id":"email_sub_cancel","x":0,"y":17,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_cancel","x":0,"y":18,"width":36,"height":5,"visibility":true},{"fld_id":"email_sub_delete","x":0,"y":23,"width":36,"height":1,"visibility":true},{"fld_id":"email_msg_delete","x":0,"y":24,"width":36,"height":5,"visibility":true}],"tableDesign":null},{"dc_id":"6","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"navigateto","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"loadopen","x":21,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_navigationparam","x":0,"y":1,"width":27,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-08-01 12:23:15', '2024-07-29 17:54:51', 'N', 'Y', 'N', '76', NULL, '0'),
('29', 'ad_pm', 'TSTRUCT', '[{"transid":"ad_pm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"11/07/2023 16:29:16","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"caption","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"processowner","x":9,"y":0,"width":10,"height":1,"visibility":true},{"fld_id":"axpicon_process","x":19,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"processtable","x":24,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"processdesc","x":0,"y":1,"width":30,"height":3,"visibility":true},{"fld_id":"cards","x":0,"y":4,"width":30,"height":1,"visibility":true},{"fld_id":"amendment","x":0,"y":5,"width":5,"height":1,"visibility":true},{"fld_id":"amendconfirm","x":5,"y":5,"width":9,"height":1,"visibility":true},{"fld_id":"amendconfirmmsg","x":0,"y":6,"width":14,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2022-10-19 01:58:27', '2023-07-11 16:30:47', 'N', 'Y', 'N', '45', NULL, '0'),
('30', 'ad_am', 'TSTRUCT', '[{"transid":"ad_am","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"14/05/2023 10:02:03","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"actorname","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"applicableto","x":17,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"sprocessname","x":0,"y":1,"width":28,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', '2023-05-14 10:02:56', '2023-05-14 10:02:56', 'N', 'Y', 'N', '72', NULL, '0'),
('31', 'ad__q', 'TSTRUCT', '[{"transid":"ad__q","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"27/11/2024 15:59:19","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxQueueName","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"AxQueueDesc","x":0,"y":1,"width":24,"height":2,"visibility":true},{"fld_id":"formcaption","x":0,"y":3,"width":24,"height":1,"visibility":true},{"fld_id":"allfields","x":24,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"formfields","x":0,"y":4,"width":24,"height":2,"visibility":true},{"fld_id":"onformdata","x":24,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"primaryfieldui","x":0,"y":6,"width":24,"height":1,"visibility":true},{"fld_id":"datasource","x":0,"y":7,"width":24,"height":1,"visibility":true},{"fld_id":"ds_forms","x":0,"y":8,"width":24,"height":2,"visibility":true},{"fld_id":"ds_interval","x":0,"y":10,"width":24,"height":1,"visibility":true},{"fld_id":"printforms","x":0,"y":11,"width":7,"height":1,"visibility":true},{"fld_id":"fileattachments","x":7,"y":11,"width":7,"height":1,"visibility":true},{"fld_id":"active","x":14,"y":11,"width":9,"height":1,"visibility":true},{"fld_id":"fastprints","x":0,"y":12,"width":24,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2024-01-11 14:55:16', '2024-11-27 16:00:27', 'N', 'Y', 'N', '94', NULL, '0'),
('39', 'a__qm', 'TSTRUCT', '[{"transid":"a__qm","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"27/09/2023 09:34:22","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxQueueName","x":0,"y":0,"width":25,"height":1,"visibility":true},{"fld_id":"AxQueueDesc","x":0,"y":1,"width":25,"height":2,"visibility":true},{"fld_id":"btn17","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"btn18","x":9,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-08-16 09:35:11', '2023-09-27 09:35:17', 'N', 'Y', 'N', '79', NULL, '0'),
('46', 'axcdm', 'TSTRUCT', '[{"transid":"axcdm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"28/04/2021 14:46:55","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cardtype","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"cardcaption","x":6,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"cardicon","x":0,"y":1,"width":8,"height":1,"visibility":true},{"fld_id":"AxpFile_cardimg","x":8,"y":1,"width":10,"height":1,"visibility":true},{"fld_id":"AxpFilePath_cardimg","x":0,"y":2,"width":18,"height":1,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', '2021-04-28 13:41:39', '2021-04-28 14:50:34', 'N', 'Y', 'N', '164', NULL, '0'),
('76', 'a__ag', 'TSTRUCT', '[{"transid":"a__ag","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"20/02/2026 10:29:32","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"grpname","x":0,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"parentgrp","x":7,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"grpvalue","x":0,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"grpparent","x":0,"y":2,"width":16,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2025-04-16 00:58:51', '2026-02-20 10:29:55', 'N', 'Y', 'N', '122', NULL, '0'),
('32', 'a__re', 'TSTRUCT', '[{"transid":"a__re","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"05/05/2025 20:55:13","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"rulename","x":0,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"formcaption","x":11,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"uroles","x":0,"y":1,"width":26,"height":2,"visibility":true},{"fld_id":"formula","x":0,"y":3,"width":26,"height":1,"visibility":true},{"fld_id":"showfieldsui","x":0,"y":4,"width":26,"height":2,"visibility":true},{"fld_id":"hidefieldsui","x":0,"y":6,"width":26,"height":2,"visibility":true},{"fld_id":"enablefieldsui","x":0,"y":8,"width":26,"height":2,"visibility":true},{"fld_id":"disablefieldsui","x":0,"y":10,"width":26,"height":2,"visibility":true},{"fld_id":"mandatoryfieldsui","x":0,"y":12,"width":26,"height":2,"visibility":true},{"fld_id":"nonmandatoryfieldsui","x":0,"y":14,"width":26,"height":2,"visibility":true},{"fld_id":"fldsmasking","x":0,"y":16,"width":26,"height":1,"visibility":true},{"fld_id":"readonly","x":0,"y":17,"width":5,"height":1,"visibility":true},{"fld_id":"cachedsave","x":5,"y":17,"width":5,"height":1,"visibility":true},{"fld_id":"active","x":10,"y":17,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', '2025-05-05 20:56:55', '2025-05-05 20:56:55', 'N', 'Y', 'N', '125', NULL, '0'),
('34', 'a__er', 'TSTRUCT', '[{"transid":"a__er","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"13/05/2024 11:56:39","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"rtypeui","x":0,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"mstructui","x":0,"y":1,"width":20,"height":1,"visibility":true},{"fld_id":"mfieldui","x":0,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"dstructui","x":0,"y":3,"width":20,"height":1,"visibility":true},{"fld_id":"dfieldui","x":0,"y":4,"width":20,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', '2024-05-13 11:57:27', '2024-05-13 11:57:27', 'N', 'Y', 'N', '101', NULL, '0'),
('35', 'a__ap', 'TSTRUCT', '[{"transid":"a__ap","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/08/2023 11:48:14","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AutoPrintId","x":0,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"form","x":7,"y":0,"width":23,"height":1,"visibility":true},{"fld_id":"formula","x":0,"y":1,"width":30,"height":1,"visibility":true},{"fld_id":"printdoc","x":0,"y":2,"width":30,"height":1,"visibility":true},{"fld_id":"directprint","x":0,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', '', 'N', '2023-09-27 09:56:16', '2023-09-27 09:56:16', 'N', 'Y', 'N', '81', NULL, '0'),
('36', 'a__na', 'TSTRUCT', '[{"transid":"a__na","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"10/03/2025 16:49:18","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"title","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"eventimg","x":21,"y":0,"width":6,"height":4,"visibility":true},{"fld_id":"subdetails","x":0,"y":1,"width":21,"height":2,"visibility":true},{"fld_id":"redirecturl","x":0,"y":3,"width":21,"height":1,"visibility":true},{"fld_id":"effectfrom","x":0,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"effecto","x":6,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":5,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2025-03-10 16:49:57', '2025-03-10 16:55:43', 'N', 'Y', 'N', '119', NULL, '0'),
('37', 'ad_af', 'TSTRUCT', '[{"transid":"ad_af","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"20-02-2025 15:26:05","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcaption","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"dcName","x":16,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"name","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"caption","x":9,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"fType","x":0,"y":2,"width":12,"height":1,"visibility":true},{"fld_id":"dataType","x":12,"y":2,"width":7,"height":1,"visibility":true},{"fld_id":"width","x":19,"y":2,"width":7,"height":1,"visibility":true},{"fld_id":"flddecimal","x":26,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"DSFormCaptionui","x":0,"y":3,"width":12,"height":1,"visibility":true},{"fld_id":"DSFieldui","x":12,"y":3,"width":20,"height":1,"visibility":true},{"fld_id":"defList","x":0,"y":4,"width":32,"height":2,"visibility":true},{"fld_id":"apiNameMO","x":0,"y":6,"width":32,"height":1,"visibility":true},{"fld_id":"defSrcFieldui","x":0,"y":7,"width":17,"height":1,"visibility":true},{"fld_id":"defTable","x":0,"y":8,"width":32,"height":5,"visibility":true},{"fld_id":"autogenprefix","x":0,"y":30,"width":5,"height":1,"visibility":true},{"fld_id":"autogenprefixfld","x":5,"y":30,"width":10,"height":1,"visibility":true},{"fld_id":"autogensno","x":15,"y":30,"width":4,"height":1,"visibility":true},{"fld_id":"autogenno","x":19,"y":30,"width":4,"height":1,"visibility":true},{"fld_id":"rangeperiod","x":23,"y":30,"width":9,"height":1,"visibility":true},{"fld_id":"exp_editor_formula","x":0,"y":31,"width":32,"height":2,"visibility":true},{"fld_id":"exp_editor_valexpr","x":0,"y":33,"width":32,"height":2,"visibility":true},{"fld_id":"allowDuplicate","x":0,"y":35,"width":6,"height":1,"visibility":true},{"fld_id":"allowEmpty","x":6,"y":35,"width":6,"height":1,"visibility":true},{"fld_id":"fldPosition","x":0,"y":36,"width":7,"height":1,"visibility":true},{"fld_id":"position","x":7,"y":36,"width":25,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2022-06-30 12:37:11', '2025-02-20 15:27:59', 'N', 'Y', 'N', '69', NULL, '0'),
('38', 'ad_pa', 'TSTRUCT', '[{"transid":"ad_pa","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"20/02/2025 15:56:28","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"publickey","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"secretkey","x":16,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"unameui","x":0,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"apitype","x":16,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"objdatasrc","x":0,"y":2,"width":31,"height":2,"visibility":true},{"fld_id":"structcapui","x":0,"y":4,"width":16,"height":1,"visibility":true},{"fld_id":"scriptcapui","x":16,"y":4,"width":8,"height":1,"visibility":true},{"fld_id":"printform","x":24,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"apirequeststring","x":0,"y":5,"width":31,"height":3,"visibility":true},{"fld_id":"apisuccess","x":0,"y":9,"width":31,"height":2,"visibility":true},{"fld_id":"apierror","x":0,"y":11,"width":31,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-12-06 20:03:03', '2025-02-20 15:56:45', 'N', 'Y', 'N', '90', NULL, '0'),
('52', 'pgv2c', 'TSTRUCT', '[{"transid":"pgv2c","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/04/2023 19:27:07","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"TaskName","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"applicability_tbl","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"taskgroupname","x":0,"y":2,"width":26,"height":1,"visibility":true},{"fld_id":"IndexNo","x":26,"y":2,"width":10,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":3,"width":4,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"taskdescription","x":0,"y":1,"width":36,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-02-24 13:03:42', '2023-04-25 19:28:34', 'N', 'Y', 'N', '65', NULL, '0'),
('40', 'axipd', 'TSTRUCT', '[{"transid":"axipd","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"01/09/2021 18:26:37","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"AxImpDefName","x":0,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"AxImpform","x":8,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"AxImpPrimayField","x":0,"y":1,"width":8,"height":1,"visibility":true},{"fld_id":"AxImpGroupField","x":8,"y":1,"width":10,"height":1,"visibility":true},{"fld_id":"AxImpHeaderRows","x":18,"y":1,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpFieldSeperatorui","x":0,"y":2,"width":5,"height":1,"visibility":true},{"fld_id":"AxImpThreadCount","x":5,"y":2,"width":3,"height":1,"visibility":true},{"fld_id":"AxImpProcessMode","x":8,"y":2,"width":14,"height":1,"visibility":true},{"fld_id":"AxImpMapFields","x":0,"y":3,"width":22,"height":1,"visibility":true},{"fld_id":"AxImpProcName","x":0,"y":4,"width":18,"height":1,"visibility":true},{"fld_id":"AxImpStdColumnWidth","x":18,"y":4,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpTextQualifier","x":0,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpMapInFile","x":4,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpBindToTStruct","x":8,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpIgnoreFldException","x":12,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"AxImpOnlyAppend","x":18,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"AxImpFilefromtable","x":0,"y":6,"width":5,"height":1,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', '2021-03-31 19:42:31', '2021-09-01 19:00:09', 'N', 'Y', 'N', '46', NULL, '0'),
('41', 'sect', 'TSTRUCT', '[{"transid":"sect","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"10-01-2025 16:09:20","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"caption","x":1,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"template","x":16,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"btn26","x":25,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"AxpFile_hpImages","x":1,"y":3,"width":33,"height":1,"visibility":true},{"fld_id":"params","x":1,"y":5,"width":27,"height":1,"visibility":true},{"fld_id":"isacoretrans","x":28,"y":5,"width":6,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"html_editor_htmlsrc","x":0,"y":0,"width":36,"height":6,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"filename","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"css_js_src","x":0,"y":2,"width":36,"height":6,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":40,"visibility":true},{"fld_id":"uniqueThHead3","width":42,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"filename","width":579,"visibility":true},{"fld_id":"filetype","width":0,"visibility":false},{"fld_id":"css_js_src","width":579,"visibility":true}]},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"filename","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"css_editor_css_js_src","x":0,"y":1,"width":36,"height":5,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":11,"visibility":true},{"fld_id":"uniqueThHead4","width":68,"visibility":true},{"fld_id":"axp_recid4","width":11,"visibility":false},{"fld_id":"filename","width":210,"visibility":true},{"fld_id":"css_editor_css_js_src","width":400,"visibility":true}]}],"newdcs":null}]', 'admin', 'admin', 'N', '2020-10-30 12:55:36', '2025-02-04 12:08:57', 'N', 'Y', 'N', '55', NULL, '0'),
('42', 'a__td', 'TSTRUCT', '[{"transid":"a__td","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"29/01/2025 17:28:05","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"dname","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"tjson","x":0,"y":1,"width":28,"height":5,"visibility":true},{"fld_id":"isactive","x":0,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', '2025-01-29 17:28:20', '2025-01-29 17:28:20', 'N', 'Y', 'N', '117', NULL, '0'),
('43', 'axeml', 'TSTRUCT', '[{"transid":"axeml","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"08/06/2021 16:25:31","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"EMailDefName","x":0,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"EMailWhat","x":11,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"emailform","x":0,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"emailiview","x":0,"y":2,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailTo","x":0,"y":3,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailCC","x":0,"y":4,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailBCC","x":0,"y":5,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailSubject","x":0,"y":6,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailAttachment","x":0,"y":7,"width":23,"height":1,"visibility":true},{"fld_id":"Axp_EMailBody","x":0,"y":8,"width":23,"height":6,"visibility":true}],"tableDesign":null}]}]', 'admin', 'abinash', 'N', '2021-03-26 22:25:09', '2021-06-08 16:29:56', 'N', 'Y', 'N', '96', NULL, '0'),
('44', 'ad_li', 'TSTRUCT', '[{"transid":"ad_li","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"24/03/2023 18:33:12","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"dispname","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"sname","x":0,"y":1,"width":24,"height":1,"visibility":true},{"fld_id":"compname","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"compcaption","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"comphint","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"lngname","x":0,"y":5,"width":9,"height":1,"visibility":true},{"fld_id":"fontname","x":0,"y":6,"width":24,"height":1,"visibility":true},{"fld_id":"fontsize","x":0,"y":7,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-03-28 10:44:05', '2023-03-28 10:44:35', 'N', 'Y', 'N', '67', NULL, '0'),
('45', 'axpub', 'TSTRUCT', '[{"transid":"axpub","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":true,"selectedLayout":"default","tstUpdatedOn":"19/10/2022 15:35:44","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"servertype","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"servername","x":0,"y":1,"width":17,"height":1,"visibility":true},{"fld_id":"serverpath","x":0,"y":2,"width":17,"height":1,"visibility":true},{"fld_id":"app_connection","x":0,"y":3,"width":17,"height":1,"visibility":true},{"fld_id":"fs_username","x":0,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"fs_password","x":9,"y":4,"width":8,"height":1,"visibility":true},{"fld_id":"ftp_dir","x":0,"y":5,"width":17,"height":1,"visibility":true},{"fld_id":"publishtodev","x":0,"y":6,"width":7,"height":1,"visibility":true},{"fld_id":"inactive","x":7,"y":6,"width":3,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"uploadtype","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"ftp_url","x":0,"y":1,"width":22,"height":1,"visibility":true},{"fld_id":"ftp_dir","x":0,"y":2,"width":22,"height":1,"visibility":true},{"fld_id":"ftp_username","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"ftp_pwd","x":9,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"ftp_port","x":18,"y":3,"width":4,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"db_type","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"db_version","x":9,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"db_host","x":16,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"db_username","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"db_pwd","x":9,"y":1,"width":7,"height":1,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', '2021-03-18 20:53:59', '2022-10-19 03:11:03', 'N', 'Y', 'N', '48', NULL, '0'),
('47', 'axapi', 'TSTRUCT', '[{"transid":"axapi","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"17/05/2022 11:33:06","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"apicategory","x":0,"y":0,"width":18,"height":1,"visibility":true},{"fld_id":"sql_output","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"formcaption","x":0,"y":1,"width":18,"height":1,"visibility":true},{"fld_id":"dd_caption","x":18,"y":1,"width":17,"height":1,"visibility":true},{"fld_id":"iviewcaption","x":0,"y":2,"width":35,"height":1,"visibility":true},{"fld_id":"page","x":0,"y":3,"width":6,"height":1,"visibility":true},{"fld_id":"pagecaption","x":6,"y":3,"width":16,"height":1,"visibility":true},{"fld_id":"pagescript","x":22,"y":3,"width":13,"height":1,"visibility":true},{"fld_id":"sql_reffield","x":0,"y":4,"width":35,"height":1,"visibility":true},{"fld_id":"sql_editor_apiquery","x":0,"y":5,"width":35,"height":2,"visibility":true},{"fld_id":"apiurl","x":0,"y":7,"width":35,"height":1,"visibility":true},{"fld_id":"reqformat","x":0,"y":8,"width":35,"height":7,"visibility":true},{"fld_id":"res_success","x":0,"y":15,"width":35,"height":2,"visibility":true},{"fld_id":"res_fail","x":0,"y":17,"width":35,"height":2,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2021-10-26 17:02:48', '2022-05-17 11:36:46', 'N', 'Y', 'N', '64', NULL, '0'),
('48', 'astcp', 'TSTRUCT', '[{"transid":"astcp","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"tstUpdatedOn":"05/05/2020 16:47:00","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"configprops","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"propcode","x":9,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"ptype","x":17,"y":0,"width":4,"height":1,"visibility":true},{"fld_id":"caction","x":21,"y":0,"width":4,"height":1,"visibility":true},{"fld_id":"description","x":0,"y":1,"width":21,"height":4,"visibility":true},{"fld_id":"chyperlink","x":21,"y":1,"width":4,"height":1,"visibility":true},{"fld_id":"cfields","x":21,"y":2,"width":5,"height":1,"visibility":true},{"fld_id":"alltstructs","x":21,"y":3,"width":8,"height":1,"visibility":true},{"fld_id":"alliviews","x":21,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"alluserroles","x":29,"y":4,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"configvalues","x":0,"y":0,"width":21,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":87,"visibility":true},{"fld_id":"uniqueThHead2","width":95,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"configvalues","width":326,"visibility":true}]}]}]', 'admin', 'admin', 'N', NULL, '2020-05-05 16:47:38', NULL, 'Y', NULL, '1901', NULL, '0'),
('49', 'axurg', 'TSTRUCT', '[{"transid":"axurg","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"24/12/2024 11:52:49","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"pusername","x":0,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"usertype","x":0,"y":1,"width":11,"height":1,"visibility":true},{"fld_id":"IsActive","x":11,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"btn17","x":0,"y":2,"width":5,"height":1,"visibility":true},{"fld_id":"btn19","x":0,"y":3,"width":5,"height":1,"visibility":true},{"fld_id":"btn18","x":0,"y":4,"width":5,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2024-09-06 12:01:04', '2025-09-30 13:50:11', 'N', 'Y', 'N', '108', NULL, '0'),
('50', 'agspr', 'TSTRUCT', '[{"transid":"agspr","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"25/06/2024 19:10:12","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"hltype","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"caption","x":9,"y":0,"width":16,"height":1,"visibility":true},{"fld_id":"searchfor","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"searchtext","x":9,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"periodically","x":0,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"fromdt","x":9,"y":2,"width":8,"height":1,"visibility":true},{"fld_id":"todt","x":17,"y":2,"width":8,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"srctrans","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"tsrcfield","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"params","x":0,"y":0,"width":36,"height":1,"visibility":true}],"tableDesign":null}]}]', NULL, 'admin', 'N', '2019-03-07 13:33:07', '2024-06-25 19:13:22', 'N', 'Y', 'N', '19', NULL, '0'),
('51', 'ad__e', 'TSTRUCT', '[{"transid":"ad__e","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"16/12/2022 11:45:44","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"eventname","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"eventcolor","x":15,"y":0,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"eventstatus","x":0,"y":0,"width":36,"height":1,"visibility":true},{"fld_id":"eventstatcolor","x":0,"y":1,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":112,"visibility":true},{"fld_id":"uniqueThHead2","width":68,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"eventstatus","width":432,"visibility":true},{"fld_id":"eventstatcolor","width":245,"visibility":true}]}]}]', 'admin', 'admin', 'N', '2022-12-13 23:44:36', '2022-12-15 22:58:37', 'N', 'Y', 'N', '83', NULL, '0'),
('59', 'sendm', 'TSTRUCT', '[{"transid":"sendm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"26/06/2019 19:12:52","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"mtype","x":0,"y":0,"width":10,"height":1,"visibility":true},{"fld_id":"template","x":10,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"keytemplate","x":0,"y":1,"width":27,"height":1,"visibility":true},{"fld_id":"keywords","x":0,"y":2,"width":27,"height":2,"visibility":true},{"fld_id":"msgsubject","x":0,"y":4,"width":27,"height":1,"visibility":true},{"fld_id":"msgcontent","x":0,"y":5,"width":13,"height":2,"visibility":true},{"fld_id":"smsmsg","x":13,"y":5,"width":14,"height":3,"visibility":true}],"tableDesign":null}]}]', 'admin', NULL, 'N', '2019-08-09 11:21:29', '2019-08-09 11:21:29', 'N', 'Y', 'N', '14', NULL, '0'),
('61', 'dsigc', 'TSTRUCT', '[{"transid":"dsigc","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"26/06/2019 19:11:34","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"transname","x":0,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"tunique","x":13,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"docname","x":0,"y":1,"width":13,"height":1,"visibility":true},{"fld_id":"doctype","x":13,"y":1,"width":7,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"prolename","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"pusername","x":15,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"ordno","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"semail","x":9,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"ssms","x":18,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"axpmailid","x":0,"y":2,"width":18,"height":1,"visibility":true},{"fld_id":"emailid","x":0,"y":3,"width":24,"height":1,"visibility":true},{"fld_id":"mobileno","x":24,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":41,"visibility":true},{"fld_id":"uniqueThHead2","width":41,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"prolename","width":101,"visibility":true},{"fld_id":"pusername","width":94,"visibility":true},{"fld_id":"ordno","width":107,"visibility":true},{"fld_id":"semail","width":153,"visibility":true},{"fld_id":"ssms","width":152,"visibility":true},{"fld_id":"axpmailid","width":100,"visibility":true},{"fld_id":"mailid","width":11,"visibility":true},{"fld_id":"tempemail","width":11,"visibility":true},{"fld_id":"tempmobile","width":11,"visibility":true},{"fld_id":"emailid","width":145,"visibility":true},{"fld_id":"mobileno","width":152,"visibility":true},{"fld_id":"emailflag","width":11,"visibility":true},{"fld_id":"mobileflag","width":11,"visibility":true}]}]}]', 'admin', NULL, 'N', '2019-08-09 11:16:47', '2019-08-09 11:16:47', 'N', 'Y', 'N', '10', NULL, '0'),
('53', 'ad_td', 'TSTRUCT', '[{"transid":"ad_td","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"24/01/2023 20:06:50","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[{"ftype":"field","id":"fromuser000F1","fontFamilly":"font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: rgb(128, 0, 128);","fontFamillyCode":"[Arial,f,f,f,clPurple,f,9]","hyperlinkJson":""}],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"fromuser","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"touser","x":0,"y":1,"width":12,"height":1,"visibility":true},{"fld_id":"fromdate","x":0,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"todate","x":6,"y":2,"width":6,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-01-24 20:07:23', '2023-01-24 21:30:07', 'N', 'Y', 'N', '62', NULL, '0'),
('54', 'ad_cp', 'TSTRUCT', '[{"transid":"ad_cp","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"28/04/2023 19:31:51","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cardtype","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"charttype","x":6,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"cardname","x":17,"y":0,"width":19,"height":1,"visibility":true},{"fld_id":"SQL_editor_cardsql","x":0,"y":1,"width":36,"height":6,"visibility":true},{"fld_id":"chartprops","x":0,"y":7,"width":36,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-04-28 19:28:22', '2023-04-28 19:32:59', 'N', 'Y', 'N', '71', NULL, '0'),
('55', 'a__sm', 'TSTRUCT', '[{"transid":"a__sm","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"10/12/2023 12:02:22","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"touser_ui","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"msgtitle","x":0,"y":1,"width":21,"height":1,"visibility":true},{"fld_id":"message","x":0,"y":2,"width":21,"height":2,"visibility":true},{"fld_id":"pagetype","x":0,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"formmode","x":9,"y":4,"width":12,"height":1,"visibility":true},{"fld_id":"formcaption","x":0,"y":5,"width":21,"height":1,"visibility":true},{"fld_id":"loadparams","x":0,"y":6,"width":21,"height":1,"visibility":true},{"fld_id":"hlink_transid","x":0,"y":7,"width":21,"height":1,"visibility":true},{"fld_id":"hlink_params","x":0,"y":8,"width":21,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-12-10 11:14:13', '2023-12-10 12:05:43', 'N', 'Y', 'N', '91', NULL, '0'),
('56', 'axcal', 'TSTRUCT', '[{"transid":"axcal","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"01/04/2022 15:08:01","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"eventname","x":0,"y":0,"width":20,"height":1,"visibility":true},{"fld_id":"notifiedon","x":20,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"uname","x":0,"y":1,"width":26,"height":1,"visibility":true},{"fld_id":"messagetext","x":0,"y":2,"width":26,"height":3,"visibility":true},{"fld_id":"eventtype","x":0,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"startdate","x":6,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"axptm_starttime","x":12,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"enddate","x":16,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"axptm_endtime","x":22,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"location","x":0,"y":6,"width":16,"height":1,"visibility":true},{"fld_id":"recurring","x":16,"y":6,"width":10,"height":1,"visibility":true},{"fld_id":"emailalert","x":0,"y":7,"width":8,"height":1,"visibility":true},{"fld_id":"statusui","x":8,"y":7,"width":7,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2021-06-05 12:15:47', '2022-04-01 15:13:04', 'N', 'Y', 'N', '57', NULL, '0'),
('57', 'temps', 'TSTRUCT', '[{"transid":"temps","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"01/02/2022 06:00:20","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"type","x":0,"y":0,"width":4,"height":1,"visibility":true},{"fld_id":"names","x":4,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"elements","x":0,"y":1,"width":19,"height":1,"visibility":true},{"fld_id":"cvalue","x":0,"y":2,"width":36,"height":7,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', '2020-03-16 10:57:21', '2022-02-01 06:47:04', 'N', 'Y', 'N', '2', NULL, '0'),
('58', 'tconf', 'TSTRUCT', '[{"transid":"tconf","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"tstUpdatedOn":"08/05/2019 12:10:53","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"structname","x":0,"y":0,"width":13,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"searchflds","x":0,"y":0,"width":14,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":42,"visibility":true},{"fld_id":"uniqueThHead2","width":83,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"searchflds","width":352,"visibility":true},{"fld_id":"acondition","width":11,"visibility":true}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"groupbtnname","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"groupbuttons","x":12,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":52,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":true},{"fld_id":"groupbtnname","width":150,"visibility":true},{"fld_id":"groupbuttons","width":400,"visibility":true},{"fld_id":"tmpgp","width":0,"visibility":true},{"fld_id":"tmpgroup","width":0,"visibility":true},{"fld_id":"bcondition","width":0,"visibility":true}]},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"html_buttonname","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"html_filename","x":12,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"html_fields","x":24,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":52,"visibility":true},{"fld_id":"uniqueThHead4","width":40,"visibility":true},{"fld_id":"axp_recid4","width":0,"visibility":true},{"fld_id":"html_buttonname","width":160,"visibility":true},{"fld_id":"html_filename","width":320,"visibility":true},{"fld_id":"html_fields","width":288,"visibility":true},{"fld_id":"t_fields","width":0,"visibility":true},{"fld_id":"t_file","width":0,"visibility":true},{"fld_id":"ccondition","width":0,"visibility":true}]},{"dc_id":"5","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"ref_struct","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"master_field","x":12,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"source_field","x":24,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"ref_idcol","x":0,"y":1,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct5","width":56,"visibility":true},{"fld_id":"uniqueThHead5","width":43,"visibility":true},{"fld_id":"axp_recid5","width":11,"visibility":true},{"fld_id":"ref_struct","width":242,"visibility":true},{"fld_id":"ref_transid","width":11,"visibility":true},{"fld_id":"master_field","width":202,"visibility":true},{"fld_id":"source_field","width":221,"visibility":true},{"fld_id":"ref_idcol","width":160,"visibility":true},{"fld_id":"dcondition","width":11,"visibility":true}]},{"dc_id":"6","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cv_searchflds","x":0,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"cv_groupbuttons","x":7,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"cv_htmlprints","x":14,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"cv_masterflds","x":23,"y":0,"width":10,"height":1,"visibility":true}],"tableDesign":null}]}]', NULL, 'admin', 'N', '2018-12-29 12:10:09', '2019-05-23 11:42:15', 'N', 'Y', 'N', '47', NULL, '0'),
('60', 'iconf', 'TSTRUCT', '[{"transid":"iconf","compressedMode":true,"newDesign":true,"staticRunMode":true,"wizardDC":false,"tstUpdatedOn":"22/04/2019 12:39:30","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"structname","x":0,"y":0,"width":10,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"groupbtnname","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"groupbuttons","x":6,"y":0,"width":18,"height":1,"visibility":true},{"fld_id":"tmpgp","x":0,"y":1,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":56,"visibility":true},{"fld_id":"uniqueThHead2","width":42,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"groupbtnname","width":207,"visibility":true},{"fld_id":"groupbuttons","width":274,"visibility":true},{"fld_id":"tmpgp","width":240,"visibility":true},{"fld_id":"tmpgroup","width":11,"visibility":true},{"fld_id":"bcondition","width":11,"visibility":true}]},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null}]}]', NULL, 'admin', 'N', '2019-01-05 13:12:49', '2019-05-23 11:40:30', 'N', 'Y', 'N', '121', NULL, '0'),
('62', 'axfin', 'TSTRUCT', '[{"transid":"axfin","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"19/06/2019 00:00:00","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"ttype","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"finyr","x":9,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"finyridentifier","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"StartDate","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"EndDate","x":9,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"CurrentFinYr","x":18,"y":1,"width":4,"height":1,"visibility":true},{"fld_id":"Closed","x":22,"y":1,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"periodcode","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"perioddesc","x":9,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"quarter","x":18,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"pstartdate","x":27,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"penddate","x":0,"y":1,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":150,"visibility":true},{"fld_id":"uniqueThHead2","width":150,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":true},{"fld_id":"dfinyr","width":11,"visibility":true},{"fld_id":"periodcode","width":150,"visibility":true},{"fld_id":"perioddesc","width":150,"visibility":true},{"fld_id":"quarter","width":150,"visibility":true},{"fld_id":"pstartdate","width":150,"visibility":true},{"fld_id":"penddate","width":150,"visibility":true},{"fld_id":"days","width":11,"visibility":true},{"fld_id":"blank","width":11,"visibility":true}]}]}]', 'admin', NULL, 'N', '2019-08-09 11:32:29', '2019-08-09 11:32:29', 'N', 'Y', 'N', '23', NULL, '0'),
('63', 'axerr', 'TSTRUCT', '[{"transid":"axerr","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"tstUpdatedOn":"26/06/2019 19:15:02","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"constraint_name","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"constraint_type","x":0,"y":1,"width":15,"height":1,"visibility":true},{"fld_id":"table_name","x":0,"y":2,"width":11,"height":1,"visibility":true},{"fld_id":"msg","x":0,"y":3,"width":15,"height":2,"visibility":true}],"tableDesign":null}]}]', 'admin', NULL, 'N', '2019-08-09 11:20:12', '2019-08-09 11:20:12', 'N', 'Y', 'N', '13', NULL, '0'),
('64', 'ad_pr', 'TSTRUCT', '[{"transid":"ad_pr","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"22/07/2025 16:28:24","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"smtphost","x":0,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"smtpport","x":0,"y":1,"width":13,"height":1,"visibility":true},{"fld_id":"smtpuser","x":0,"y":2,"width":13,"height":1,"visibility":true},{"fld_id":"smtppwd","x":0,"y":3,"width":13,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"axpsiteno","x":0,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"amtinmillions","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"currseperator","x":0,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"lastlogin","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"autogen","x":0,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"customfrom","x":0,"y":5,"width":12,"height":1,"visibility":true},{"fld_id":"customto","x":13,"y":5,"width":11,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"loginattempt","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"pwdencrypt","x":15,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"pwdexp","x":0,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"pwdalphanum","x":15,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"pwdchange","x":0,"y":2,"width":14,"height":1,"visibility":true},{"fld_id":"pwdcapchar","x":15,"y":2,"width":9,"height":1,"visibility":true},{"fld_id":"pwdminchar","x":0,"y":3,"width":14,"height":1,"visibility":true},{"fld_id":"pwdsmallchar","x":15,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"pwdmaxchar","x":0,"y":4,"width":14,"height":1,"visibility":true},{"fld_id":"pwdnumchar","x":15,"y":4,"width":9,"height":1,"visibility":true},{"fld_id":"pwdreuse","x":0,"y":5,"width":14,"height":1,"visibility":true},{"fld_id":"pwdsplchar","x":15,"y":5,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"otpauth","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"otpchars","x":6,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"otpexpiry","x":13,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"emailsubject","x":0,"y":1,"width":26,"height":1,"visibility":true},{"fld_id":"emailbody","x":0,"y":2,"width":26,"height":4,"visibility":true},{"fld_id":"smscontent","x":0,"y":6,"width":26,"height":4,"visibility":true}],"tableDesign":null},{"dc_id":"5","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"sso_windows","x":0,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_windows","x":6,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"sso_saml","x":0,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_saml","x":6,"y":2,"width":23,"height":1,"visibility":true},{"fld_id":"sso_office365","x":0,"y":3,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_office365","x":6,"y":3,"width":23,"height":1,"visibility":true},{"fld_id":"sso_okta","x":0,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_okta","x":6,"y":4,"width":23,"height":1,"visibility":true},{"fld_id":"sso_google","x":0,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_google","x":6,"y":5,"width":23,"height":1,"visibility":true},{"fld_id":"sso_facebook","x":0,"y":6,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_facebook","x":6,"y":6,"width":23,"height":1,"visibility":true},{"fld_id":"sso_openid","x":0,"y":7,"width":6,"height":1,"visibility":true},{"fld_id":"tbl_openid","x":6,"y":7,"width":23,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'abhinash', 'admin', 'N', '2022-01-10 19:51:44', '2025-07-22 16:29:15', 'N', 'Y', 'N', '8', NULL, '0'),
('65', 'ad_lg', 'TSTRUCT', '[{"transid":"ad_lg","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":true,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"26/04/2023 18:03:26","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"20","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"language","x":0,"y":0,"width":17,"height":1,"visibility":true},{"fld_id":"fontcharset","x":0,"y":1,"width":17,"height":1,"visibility":true},{"fld_id":"fontname","x":0,"y":2,"width":12,"height":1,"visibility":true},{"fld_id":"fontsize","x":12,"y":2,"width":5,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"exportfiles","x":0,"y":0,"width":36,"height":2,"visibility":true},{"fld_id":"tstructcap","x":0,"y":2,"width":36,"height":2,"visibility":true},{"fld_id":"iviewcap","x":0,"y":4,"width":36,"height":2,"visibility":true},{"fld_id":"btn22","x":0,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"3","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"uploadfiletype","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"btn23","x":6,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"btn26","x":12,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"btn24","x":0,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"btn25","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2022-09-06 19:20:49', '2023-04-26 18:03:40', 'N', 'Y', 'N', '53', NULL, '0'),
('67', 'axvar', 'TSTRUCT', '[{"transid":"axvar","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"26/09/2022 13:46:56","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"vpname","x":0,"y":0,"width":15,"height":1,"visibility":true},{"fld_id":"vscript","x":0,"y":1,"width":22,"height":5,"visibility":true},{"fld_id":"pcaption","x":0,"y":6,"width":11,"height":1,"visibility":true},{"fld_id":"pdatatype","x":11,"y":6,"width":6,"height":1,"visibility":true},{"fld_id":"modeofentry","x":17,"y":6,"width":5,"height":1,"visibility":true},{"fld_id":"SQL_editor_psql","x":0,"y":7,"width":22,"height":6,"visibility":true},{"fld_id":"masterdlui","x":0,"y":13,"width":11,"height":1,"visibility":true},{"fld_id":"source","x":11,"y":13,"width":11,"height":1,"visibility":true},{"fld_id":"vpvalue","x":0,"y":14,"width":22,"height":1,"visibility":true},{"fld_id":"display","x":0,"y":15,"width":5,"height":1,"visibility":true},{"fld_id":"readonly","x":5,"y":15,"width":5,"height":1,"visibility":true},{"fld_id":"remarks","x":0,"y":16,"width":22,"height":2,"visibility":true}],"tableDesign":null}]}]', 'admin', 'admin', 'N', '2021-04-08 15:54:29', '2022-09-26 13:47:27', 'N', 'Y', 'N', '49', NULL, '0'),
('68', 'apidg', 'TSTRUCT', '[{"transid":"apidg","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"18-11-2025 12:18:51","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"ExecAPIDefName","x":0,"y":0,"width":28,"height":1,"visibility":true},{"fld_id":"APItype","x":0,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"ExecAPIMethod","x":14,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"APIResponseFormat","x":19,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"btn17","x":24,"y":1,"width":5,"height":1,"visibility":true},{"fld_id":"config_url_name","x":0,"y":2,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIURL","x":0,"y":3,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIParameterString","x":0,"y":4,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIHeaderString","x":0,"y":5,"width":28,"height":1,"visibility":true},{"fld_id":"ExecAPIbodyparamstring","x":0,"y":7,"width":28,"height":2,"visibility":true},{"fld_id":"ExecAPIRequestString","x":0,"y":9,"width":28,"height":5,"visibility":true},{"fld_id":"APIResponseString","x":0,"y":14,"width":28,"height":6,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"ExecAPIBasedOn","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"ExecAPIform","x":0,"y":1,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIFilterString","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIlPrintFormNames","x":0,"y":3,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIFormAttachments","x":0,"y":4,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIIVIew","x":0,"y":5,"width":24,"height":1,"visibility":true},{"fld_id":"ExecAPIIParams","x":0,"y":6,"width":24,"height":1,"visibility":true},{"fld_id":"SQL_editor_ExecAPISQLText","x":0,"y":7,"width":24,"height":7,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2021-04-03 14:22:17', '2025-11-18 12:21:05', 'N', 'Y', 'N', '127', NULL, '0'),
('69', 'ctype', 'TSTRUCT', '[{"transid":"ctype","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"28-11-2025 12:10:29","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"typename","x":0,"y":0,"width":10,"height":1,"visibility":true},{"fld_id":"isspldatatpye","x":10,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"datatype","x":0,"y":1,"width":10,"height":1,"visibility":true},{"fld_id":"spldatatype","x":0,"y":2,"width":10,"height":1,"visibility":true},{"fld_id":"width","x":0,"y":3,"width":5,"height":1,"visibility":true},{"fld_id":"dwidth","x":5,"y":3,"width":5,"height":1,"visibility":true},{"fld_id":"isactive","x":0,"y":4,"width":5,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2021-08-03 17:01:22', '2025-11-28 12:11:31', 'N', 'Y', 'N', '118', NULL, '0'),
('71', 'a__ug', 'TSTRUCT', '[{"transid":"a__ug","compressedMode":false,"newDesign":true,"staticRunMode":true,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"16/12/2024 15:25:29","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"users_group_name","x":0,"y":0,"width":13,"height":1,"visibility":true},{"fld_id":"users_group_description","x":0,"y":1,"width":31,"height":1,"visibility":true},{"fld_id":"isactive","x":0,"y":2,"width":4,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-11-04 20:28:59', '2024-12-19 17:19:23', 'N', 'Y', 'N', '85', NULL, '0'),
('72', 'ad_at', 'TSTRUCT', '[{"transid":"ad_at","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/09/2025 19:19:09","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"process","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"taskname","x":14,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"actorname","x":0,"y":1,"width":14,"height":1,"visibility":true},{"fld_id":"assignmode","x":0,"y":2,"width":14,"height":1,"visibility":true},{"fld_id":"defusername","x":0,"y":3,"width":28,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"usergroupname","x":0,"y":2,"width":24,"height":1,"visibility":true},{"fld_id":"ugrpusername","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":28,"visibility":true},{"fld_id":"uniqueThHead2","width":40,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"usergroupname","width":274,"visibility":true},{"fld_id":"usergrpcode","width":0,"visibility":false},{"fld_id":"oldugrpusername","width":0,"visibility":false},{"fld_id":"ugrpusername","width":599,"visibility":true},{"fld_id":"ugrpcnt","width":0,"visibility":false},{"fld_id":"ug_actorname","width":0,"visibility":false}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"tbl_datagrp","x":0,"y":3,"width":36,"height":1,"visibility":true},{"fld_id":"datagrpusers","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"dgname","x":0,"y":6,"width":24,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":28,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"cndopr","width":0,"visibility":false},{"fld_id":"fldcnd","width":0,"visibility":false},{"fld_id":"dg_actorname","width":0,"visibility":false},{"fld_id":"dgname","width":275,"visibility":true},{"fld_id":"tbl_datagrp","width":300,"visibility":true},{"fld_id":"olddatagrpusers","width":0,"visibility":false},{"fld_id":"datagrpusers","width":359,"visibility":true},{"fld_id":"cndcnt","width":0,"visibility":false}]},{"dc_id":"4","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"cnd","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"fldcnd","x":0,"y":1,"width":36,"height":1,"visibility":true},{"fld_id":"cndopr","x":0,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"fldvalue","x":0,"y":3,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct4","width":40,"visibility":true},{"fld_id":"uniqueThHead4","width":65,"visibility":true},{"fld_id":"axp_recid4","width":12,"visibility":false},{"fld_id":"cnd","width":134,"visibility":true},{"fld_id":"fldcnd","width":489,"visibility":true},{"fld_id":"stransid","width":12,"visibility":false},{"fld_id":"isformfld","width":12,"visibility":false},{"fld_id":"fldname","width":12,"visibility":false},{"fld_id":"isnum_date","width":12,"visibility":false},{"fld_id":"cndopr","width":289,"visibility":true},{"fld_id":"fldvalue","width":496,"visibility":true},{"fld_id":"cndoprsym","width":12,"visibility":false},{"fld_id":"cndcnt","width":12,"visibility":false},{"fld_id":"condition","width":12,"visibility":false}]}],"newdcs":null}]', 'admin', 'admin', 'N', '2022-11-23 21:25:35', '2025-12-02 14:22:00', 'N', 'Y', 'N', '52', NULL, '0'),
('66', 'a__ua', 'TSTRUCT', '[{"transid":"a__ua","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"07/02/2026 17:05:25","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"pusername","x":0,"y":0,"width":11,"height":1,"visibility":true},{"fld_id":"adminaccess","x":11,"y":0,"width":14,"height":2,"visibility":true},{"fld_id":"usergroups","x":0,"y":2,"width":25,"height":2,"visibility":true},{"fld_id":"mobile","x":0,"y":6,"width":11,"height":1,"visibility":true},{"fld_id":"email","x":11,"y":6,"width":14,"height":1,"visibility":true},{"fld_id":"pwdauth","x":0,"y":7,"width":6,"height":1,"visibility":true},{"fld_id":"otpauth","x":6,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"portaluser","x":11,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"staysignedin","x":16,"y":7,"width":4,"height":1,"visibility":true},{"fld_id":"signinexpiry","x":20,"y":7,"width":5,"height":1,"visibility":true},{"fld_id":"actflag","x":0,"y":8,"width":6,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"axusergroup","x":15,"y":1,"width":12,"height":1,"visibility":true},{"fld_id":"startdate","x":27,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"enddate","x":0,"y":3,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":150,"visibility":true},{"fld_id":"uniqueThHead2","width":150,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"axusername","width":0,"visibility":false},{"fld_id":"axusergroup","width":240,"visibility":true},{"fld_id":"startdate","width":150,"visibility":true},{"fld_id":"enddate","width":150,"visibility":true},{"fld_id":"validrow2","width":0,"visibility":false}]},{"dc_id":"3","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"axuserrole","x":0,"y":0,"width":36,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct3","width":20,"visibility":true},{"fld_id":"uniqueThHead3","width":40,"visibility":true},{"fld_id":"axp_recid3","width":0,"visibility":false},{"fld_id":"axuserrole","width":294,"visibility":true},{"fld_id":"sqltext","width":0,"visibility":false},{"fld_id":"cnd","width":0,"visibility":false}]},{"dc_id":"4","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2024-11-27 14:16:14', '2026-02-07 17:07:52', 'N', 'Y', 'N', '111', NULL, '0'),
('75', 'axrol', 'TSTRUCT', '[{"transid":"axrol","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","tstUpdatedOn":"29/09/2021 16:30:28","dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"groupname","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"roletype","x":6,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"dhomepage","x":0,"y":1,"width":12,"height":1,"visibility":true},{"fld_id":"selfregistration","x":0,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"apprequired","x":6,"y":2,"width":6,"height":1,"visibility":true},{"fld_id":"approvedby","x":0,"y":3,"width":12,"height":1,"visibility":true},{"fld_id":"active","x":0,"y":4,"width":3,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"roles_id","x":0,"y":0,"width":12,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":89,"visibility":true},{"fld_id":"uniqueThHead2","width":82,"visibility":true},{"fld_id":"axp_recid2","width":11,"visibility":false},{"fld_id":"roles_id","width":412,"visibility":true}]}]}]', '', 'admin', 'N', '2018-12-29 12:08:09', '2021-09-29 17:07:07', 'N', 'Y', 'N', '13', NULL, '0'),
('77', 'a__cd', 'TSTRUCT', '[{"transid":"a__cd","compressedMode":false,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"25/08/2025 10:46:22","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"cardtype","x":0,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"charttype","x":8,"y":0,"width":12,"height":1,"visibility":true},{"fld_id":"cardname","x":0,"y":1,"width":20,"height":1,"visibility":true},{"fld_id":"card_datasource","x":0,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"pluginname","x":0,"y":3,"width":20,"height":1,"visibility":true},{"fld_id":"widthui","x":0,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"heightui","x":7,"y":4,"width":7,"height":1,"visibility":true},{"fld_id":"orderno","x":14,"y":4,"width":6,"height":1,"visibility":true},{"fld_id":"chartprops","x":0,"y":5,"width":20,"height":1,"visibility":true},{"fld_id":"accessstringui","x":0,"y":6,"width":20,"height":2,"visibility":true},{"fld_id":"inhomepage","x":0,"y":8,"width":6,"height":1,"visibility":true},{"fld_id":"indashboard","x":6,"y":8,"width":6,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2025-01-13 19:20:16', '2025-08-25 10:47:13', 'N', 'Y', 'N', '116', NULL, '0'),
('33', 'a__pn', 'TSTRUCT', '[{"transid":"a__pn","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"21/06/2024 11:25:14","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"name","x":0,"y":0,"width":14,"height":1,"visibility":true},{"fld_id":"startdate","x":14,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"starttime","x":21,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"frequency","x":0,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"sendday","x":7,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"sendon","x":14,"y":1,"width":7,"height":1,"visibility":true},{"fld_id":"sendtime","x":21,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"datasource","x":0,"y":2,"width":7,"height":1,"visibility":true},{"fld_id":"messagetitle","x":7,"y":2,"width":20,"height":1,"visibility":true},{"fld_id":"MessageText","x":0,"y":3,"width":27,"height":3,"visibility":true},{"fld_id":"messageattsingle","x":0,"y":6,"width":12,"height":1,"visibility":true},{"fld_id":"messageattachmentsui","x":12,"y":6,"width":15,"height":2,"visibility":true},{"fld_id":"fromuserui","x":0,"y":8,"width":12,"height":1,"visibility":true},{"fld_id":"notifyto","x":12,"y":8,"width":15,"height":2,"visibility":true},{"fld_id":"usergroups","x":0,"y":10,"width":27,"height":2,"visibility":true},{"fld_id":"usernames","x":0,"y":12,"width":27,"height":2,"visibility":true},{"fld_id":"externalemails","x":0,"y":14,"width":27,"height":1,"visibility":true},{"fld_id":"mobilenotify","x":0,"y":15,"width":7,"height":1,"visibility":true},{"fld_id":"active","x":7,"y":15,"width":7,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"navigateto","x":0,"y":0,"width":23,"height":1,"visibility":true},{"fld_id":"loadopen","x":23,"y":0,"width":5,"height":1,"visibility":true},{"fld_id":"tbl_navigationparam","x":0,"y":1,"width":23,"height":1,"visibility":true},{"fld_id":"formula","x":0,"y":2,"width":23,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2023-08-03 15:45:05', '2024-06-21 11:32:44', 'N', 'Y', 'N', '77', NULL, '0'),
('73', 'b_sql', 'TSTRUCT', '[{"transid":"b_sql","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"tabbed","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"04/02/2026 17:45:57","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"sqlname","x":0,"y":0,"width":21,"height":1,"visibility":true},{"fld_id":"sqlsrc","x":21,"y":0,"width":7,"height":1,"visibility":true},{"fld_id":"adsdesc","x":0,"y":1,"width":28,"height":2,"visibility":true},{"fld_id":"sqltext","x":0,"y":3,"width":28,"height":6,"visibility":true},{"fld_id":"sqlparams","x":0,"y":9,"width":28,"height":1,"visibility":true},{"fld_id":"sqlquerycols","x":0,"y":10,"width":28,"height":1,"visibility":true},{"fld_id":"encryptedflds","x":0,"y":11,"width":28,"height":1,"visibility":true},{"fld_id":"smartlistcnd","x":0,"y":12,"width":28,"height":2,"visibility":true},{"fld_id":"cachedata","x":0,"y":14,"width":5,"height":1,"visibility":true},{"fld_id":"cacheinterval","x":5,"y":14,"width":7,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"T","gridStretch":false,"fieldsDesign":[{"fld_id":"fldname","x":0,"y":0,"width":24,"height":1,"visibility":true},{"fld_id":"fldcaption","x":0,"y":1,"width":24,"height":1,"visibility":true},{"fld_id":"sourcetable","x":0,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"sourcefld","x":15,"y":2,"width":15,"height":1,"visibility":true},{"fld_id":"hyp_structtype","x":0,"y":3,"width":9,"height":1,"visibility":true},{"fld_id":"hyp_struct","x":0,"y":4,"width":36,"height":1,"visibility":true},{"fld_id":"tbl_hyperlink","x":0,"y":5,"width":36,"height":1,"visibility":true},{"fld_id":"datatypeui","x":0,"y":6,"width":9,"height":1,"visibility":true},{"fld_id":"filter","x":9,"y":6,"width":9,"height":1,"visibility":true}],"tableDesign":[{"fld_id":"uniqueEditDeleteAct2","width":44,"visibility":true},{"fld_id":"uniqueThHead2","width":47,"visibility":true},{"fld_id":"axp_recid2","width":0,"visibility":false},{"fld_id":"fldname","width":235,"visibility":true},{"fld_id":"fldcaption","width":286,"visibility":true},{"fld_id":"datatypeui","width":152,"visibility":true},{"fld_id":"fdatatype","width":0,"visibility":false},{"fld_id":"filter","width":105,"visibility":true},{"fld_id":"sourcetable","width":242,"visibility":true},{"fld_id":"sourcefld","width":222,"visibility":true},{"fld_id":"normalized","width":0,"visibility":false},{"fld_id":"hyp_structtype","width":113,"visibility":true},{"fld_id":"hyp_stype","width":0,"visibility":false},{"fld_id":"hyp_struct","width":422,"visibility":true},{"fld_id":"hyp_transid","width":0,"visibility":false},{"fld_id":"hyp_structsource","width":0,"visibility":false},{"fld_id":"hyp_target","width":0,"visibility":false},{"fld_id":"tbl_hyperlink","width":400,"visibility":true}]}],"newdcs":null}]', 'admin', 'admin', 'N', '2021-01-19 16:07:00', '2026-02-04 18:04:54', 'N', 'Y', 'N', '124', NULL, '0'),
('70', 'job_s', 'TSTRUCT', '[{"transid":"job_s","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"03-03-2026 17:01:07","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"jobid","x":0,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"jname","x":6,"y":0,"width":19,"height":1,"visibility":true},{"fld_id":"priority","x":25,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"exp_editor_jobscript","x":0,"y":1,"width":31,"height":4,"visibility":true},{"fld_id":"jobschedule","x":0,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"weekday","x":6,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"jobstartfrom","x":12,"y":5,"width":7,"height":1,"visibility":true},{"fld_id":"axptm_starttime","x":19,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"jday","x":25,"y":5,"width":6,"height":1,"visibility":true},{"fld_id":"noofmins","x":31,"y":5,"width":4,"height":1,"visibility":true},{"fld_id":"Remarks","x":0,"y":6,"width":31,"height":1,"visibility":true},{"fld_id":"deletepending","x":0,"y":7,"width":6,"height":1,"visibility":true},{"fld_id":"isactive","x":6,"y":7,"width":4,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2021-02-23 14:16:48', '2026-03-03 17:28:15', 'N', 'Y', 'N', '69', NULL, '0'),
('74', 'a__up', 'TSTRUCT', '[{"transid":"a__up","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"28","tstUpdatedOn":"09/03/2026 16:46:47","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"axuserrole","x":0,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"axusername","x":8,"y":0,"width":8,"height":1,"visibility":true},{"fld_id":"comptype","x":16,"y":0,"width":6,"height":1,"visibility":true},{"fld_id":"formcap","x":0,"y":1,"width":16,"height":1,"visibility":true},{"fld_id":"allowcreate","x":16,"y":1,"width":6,"height":1,"visibility":true},{"fld_id":"viewcnd","x":0,"y":2,"width":22,"height":1,"visibility":true},{"fld_id":"view_flds","x":0,"y":3,"width":22,"height":2,"visibility":true},{"fld_id":"editcnd","x":0,"y":5,"width":22,"height":1,"visibility":true},{"fld_id":"edit_flds","x":0,"y":6,"width":22,"height":2,"visibility":true},{"fld_id":"fieldmasks","x":0,"y":8,"width":22,"height":1,"visibility":true}],"tableDesign":null},{"dc_id":"2","isGrid":"F","gridStretch":false,"fieldsDesign":null,"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2025-03-24 15:45:37', '2026-03-09 16:55:43', 'N', 'Y', 'N', '120', NULL, '0'),
('22', 'a_pgm', 'TSTRUCT', '[{"transid":"a_pgm","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":"default","selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"20/02/2026 10:21:19","dcLayout":"default","formWidth":"100","formAlignment":"default","fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"grpname","x":0,"y":0,"width":9,"height":1,"visibility":true},{"fld_id":"grpcaption","x":0,"y":1,"width":9,"height":1,"visibility":true},{"fld_id":"parentgrp","x":0,"y":2,"width":9,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', 'admin', 'N', '2025-04-17 18:29:10', '2026-02-20 10:25:21', 'N', 'Y', 'N', '123', NULL, '0'),
('78', 'a_pgt', 'TSTRUCT', '[{"transid":"a_pgt","compressedMode":true,"newDesign":true,"staticRunMode":false,"wizardDC":false,"selectedLayout":null,"selectedFontSize":"14","selectedControlHeight":"24","tstUpdatedOn":"14/04/2025 06:45:07","dcLayout":"default","formWidth":"100","formAlignment":null,"fieldCaptionWidth":"30","formLabel":[],"buttonFieldFont":[],"dcs":[{"dc_id":"1","isGrid":"F","gridStretch":false,"fieldsDesign":[{"fld_id":"formcap","x":0,"y":0,"width":15,"height":1,"visibility":true}],"tableDesign":null}],"newdcs":null}]', 'admin', NULL, 'N', '2025-04-16 00:58:22', '2025-04-16 00:58:22', 'N', 'Y', 'N', '121', NULL, '0')
ON CONFLICT DO NOTHING;

-- Seed: ax_mobile_response (0 rows)
-- No rows in source dump for ax_mobile_response.

-- Seed: ax_mobile_user (0 rows)
-- No rows in source dump for ax_mobile_user.

-- Seed: ax_notify (0 rows)
-- No rows in source dump for ax_notify.

-- Seed: ax_notify_users (0 rows)
-- No rows in source dump for ax_notify_users.

-- Seed: ax_notify_workflow (0 rows)
-- No rows in source dump for ax_notify_workflow.

-- Seed: ax_page_responsibility (0 rows)
-- No rows in source dump for ax_page_responsibility.

-- Seed: ax_page_saved (1 rows)
INSERT INTO {schema}.ax_page_saved (page_id, title, type, module, template, page_menu, content, created_by, updated_by, is_deleted, created_on, updated_on, is_migrated, is_lock, is_publish, is_private, is_default, parent_page_id, responsibility, order_by, widget_groups)
VALUES
('1', 'Homepage', NULL, 'PAGE', '1', 'Head19', NULL, NULL, NULL, 'N', '2025-06-26 14:40:42.22179', '2025-06-26 14:40:42.22179', 'N', 'N', 'N', 'N', 'Y', NULL, NULL, NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: ax_page_sd_responsibility (0 rows)
-- No rows in source dump for ax_page_sd_responsibility.

-- Seed: ax_page_templates (9 rows)
INSERT INTO {schema}.ax_page_templates (template_id, title, module, content, created_by, updated_by, is_deleted, created_on, updated_on)
VALUES
('1', 'basic', NULL, '{"cc":1,"img":"basic.png","name":"basic","cf":[{"ht":"225px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.068845', '2025-06-26 14:40:42.068845'),
('2', 'modern', NULL, '{"cc":1,"img":"modern.png","name":"modern","cf":[{"ht":"225px","isResp":true,"wd":"m3 l3","ms":"classic","br":"14px","tr":{"p":"top","h":"70px","html":"<span style=\"float:left;font-size:45px;\">#TITLE_ICON#</span><span style=\"text-align: right;padding-top: 14px;position: relative;top: 16px;right: 5px;\">#TITLE_NAME#</span>"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.083598', '2025-06-26 14:40:42.083598'),
('3', 'mainCard', NULL, '{"cc":7,"img":"mainCard.png","name":"mainCard","cf":[{"ht":"225px","isResp":true,"wd":"m12 l12","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.086174', '2025-06-26 14:40:42.086174'),
('4', 'topaz', NULL, '{"cc":5,"img":"topaz.png","name":"topaz","cf":[{"ht":"225px","isResp":true,"wd":"m12 l12","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m8 l8","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m8 l8","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m4 l4","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.088503', '2025-06-26 14:40:42.088503'),
('5', 'list', NULL, '{"cc":1,"img":"list.png","name":"list","cf":[{"ht":"225px","isResp":true,"wd":"m12 l12","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.090769', '2025-06-26 14:40:42.090769'),
('6', 'flow', NULL, '{"cc":3,"img":"flow.png","name":"flow","repeatLastWidget":true,"cf":[{"ht":"500px","isResp":true,"wd":"m6 l6","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"500px","isResp":true,"wd":"m6 l6","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.093517', '2025-06-26 14:40:42.093517'),
('7', 'checkered', NULL, '{"cc":1,"img":"checkered.png","name":"checkered","cf":[{"ht":"300px","isResp":true,"wd":"m6 l6","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.095786', '2025-06-26 14:40:42.095786'),
('8', 'flow main', NULL, '{"cc":3,"img":"flow_main.png","name":"flow main","repeatLastWidget":true,"cf":[{"ht":"300px","isResp":true,"wd":"m12 l12","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"300px","isResp":true,"wd":"m12 l12","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"225px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.098095', '2025-06-26 14:40:42.098095'),
('9', 'random', NULL, '{"cc":7,"img":"random.png","name":"random","cf":[{"ht":"130px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"130px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"130px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"130px","isResp":true,"wd":"m3 l3","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"300px","isResp":true,"wd":"m6 l6","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"300px","isResp":true,"wd":"m6 l6","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}},{"ht":"200px","isResp":true,"wd":"m12 l12","ms":"classic","tr":{"p":"top","h":"35px","html":"#TITLE_ICON# #TITLE_NAME#"}}]}', 'admin', NULL, 'N', '2025-06-26 14:40:42.100433', '2025-06-26 14:40:42.100433')
ON CONFLICT DO NOTHING;

-- Seed: ax_pages (0 rows)
-- No rows in source dump for ax_pages.

-- Seed: ax_user_settings (7 rows)
INSERT INTO {schema}.ax_user_settings (username, ir_config, appsettings)
VALUES
('admin', NULL, '{}'),
('admin', NULL, '{}'),
('admin', NULL, '{}'),
('admin', NULL, '{}'),
('admin', NULL, '{}'),
('admin', NULL, '{}'),
('admin', NULL, '{}')
ON CONFLICT DO NOTHING;

-- Seed: ax_userconfigdata (0 rows)
-- No rows in source dump for ax_userconfigdata.

-- Seed: ax_widget (0 rows)
-- No rows in source dump for ax_widget.

-- Seed: ax_widget_published (0 rows)
-- No rows in source dump for ax_widget_published.

-- Seed: ax_widget_responsibility (0 rows)
-- No rows in source dump for ax_widget_responsibility.

-- Seed: ax_widget_saved (0 rows)
-- No rows in source dump for ax_widget_saved.

-- Seed: axaction (0 rows)
-- No rows in source dump for axaction.

-- Seed: axactivemessages (0 rows)
-- No rows in source dump for axactivemessages.

-- Seed: axactivetaskdata (0 rows)
-- No rows in source dump for axactivetaskdata.

-- Seed: axactivetaskparams (0 rows)
-- No rows in source dump for axactivetaskparams.

-- Seed: axactivetasks (0 rows)
-- No rows in source dump for axactivetasks.

-- Seed: axactivetaskstatus (0 rows)
-- No rows in source dump for axactivetaskstatus.

-- Seed: axamend (0 rows)
-- No rows in source dump for axamend.

-- Seed: axapijobdetails (0 rows)
-- No rows in source dump for axapijobdetails.

-- Seed: axappconfig (0 rows)
-- No rows in source dump for axappconfig.

-- Seed: axattachworkflow (0 rows)
-- No rows in source dump for axattachworkflow.

-- Seed: axaudit (0 rows)
-- No rows in source dump for axaudit.

-- Seed: axautoprints (0 rows)
-- No rows in source dump for axautoprints.

-- Seed: axcalendar (0 rows)
-- No rows in source dump for axcalendar.

-- Seed: axcardtypemaster (9 rows)
INSERT INTO {schema}.axcardtypemaster (axcardtypemasterid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, cardtype, cardcaption, cardicon, axpfile_cardimg, axpfilepath_cardimg)
VALUES
('1362010000000', 'F', '0', NULL, 'abinash', '2021-04-28 19:18:59', 'abinash', '2021-04-28 19:18:42', NULL, '1', '1', NULL, NULL, NULL, 'chart', 'Chart', '', '', ''),
('1362220000000', 'F', '0', NULL, 'abinash', '2021-04-28 19:22:00', 'abinash', '2021-04-28 19:22:00', NULL, '1', '1', NULL, NULL, NULL, 'kpi', 'KPI', NULL, NULL, NULL),
('1362440000000', 'F', '0', NULL, 'abinash', '2021-04-28 19:22:50', 'abinash', '2021-04-28 19:22:50', NULL, '1', '1', NULL, NULL, NULL, 'list', 'List', NULL, NULL, NULL),
('1362550000000', 'F', '0', NULL, 'abinash', '2021-04-28 19:23:04', 'abinash', '2021-04-28 19:23:04', NULL, '1', '1', NULL, NULL, NULL, 'menu', 'Menu card', NULL, NULL, NULL),
('1362660000000', 'F', '0', NULL, 'abinash', '2021-04-28 19:23:23', 'abinash', '2021-04-28 19:23:23', NULL, '1', '1', NULL, NULL, NULL, 'modern menu', 'Modern menu', NULL, NULL, NULL),
('1659550000037', 'F', '0', NULL, 'abinash', '2021-05-07 09:33:54', 'abinash', '2021-05-07 09:33:54', NULL, '1', '1', NULL, NULL, NULL, 'image card', 'Image card', NULL, NULL, NULL),
('1962990000000', 'F', '0', NULL, 'abinash', '2021-06-09 16:04:56', 'abinash', '2021-06-09 16:04:56', NULL, '1', '1', NULL, NULL, NULL, 'calendar', 'Calendar', NULL, NULL, NULL),
('1042770000000', 'F', '0', NULL, 'admin', '2022-01-24 19:52:53', 'admin', '2022-01-24 19:52:53', NULL, '1', '1', NULL, NULL, NULL, 'html', 'HTML Card', NULL, NULL, NULL),
('8139880000000', 'F', '0', NULL, 'admin', '2023-04-26 18:15:25', 'admin', '2023-04-26 18:15:25', NULL, '1', '1', NULL, NULL, NULL, 'options card', 'options card', NULL, NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axconstraints (0 rows)
-- No rows in source dump for axconstraints.

-- Seed: axctx1 (48 rows)
INSERT INTO {schema}.axctx1 (atype, axcontext)
VALUES
('Property', 'Disablesplit'),
('Property', 'Navigation'),
('Property', 'FetchSize'),
('Property', 'General'),
('Property', 'SaveImage'),
('Property', 'ApplicationTemplate'),
('Property', 'mainPageTemplate'),
('Property', 'WebService Timeout'),
('Property', 'Trim IView Data'),
('Property', 'Excel Export'),
('Property', 'ExportVerticalAlign'),
('Property', 'Autocomplete Search Pattern'),
('Property', 'File Upload Limit'),
('Property', 'camera option'),
('Property', 'Date format'),
('Property', 'Text'),
('Property', 'Lds'),
('Property', 'GridEdit'),
('Property', 'FormLoad'),
('Property', 'Multi Select'),
('Property', 'Resolve Attachment Path'),
('Property', 'Custom JavaScript'),
('Property', 'Custom CSS'),
('Property', 'Auto Save Draft'),
('Property', 'Show keyboard in Hybrid App'),
('Property', 'Mobile Reports as Table'),
('Property', 'Iview Button Style'),
('Property', 'icon path'),
('Property', 'Tstruct Button Style'),
('Property', 'Apply Mobile UI'),
('Property', 'Split Ratio'),
('Property', 'Iview Retain Parameters On Next Load'),
('Property', 'Fixed Header for Grid'),
('Property', 'Iview Responsive Column Width'),
('Property', 'Not Fill Dependent Fields'),
('Property', 'Fill Dependent Fields'),
('Property', 'Striped Reports UI'),
('Property', 'HomePageTemplate'),
('Property', 'CompressedMode'),
('Property', 'Upload file types'),
('Property', 'Autosplit'),
('Property', 'Google Maps Zoom'),
('Property', 'Iview Session Caching'),
('Property', 'column separator for reports'),
('Property', 'Popup fillgrid data based on query order'),
('Property', 'Popup fillgrid data show all'),
('Property', 'Unicode support for PDF export'),
('Property', 'Auto column width for report based on data')
ON CONFLICT DO NOTHING;

-- Seed: axcustomviews (0 rows)
-- No rows in source dump for axcustomviews.

-- Seed: axdef_newfield (0 rows)
-- No rows in source dump for axdef_newfield.

-- Seed: axdelegatedtasks (0 rows)
-- No rows in source dump for axdelegatedtasks.

-- Seed: axdelegateusers (0 rows)
-- No rows in source dump for axdelegateusers.

-- Seed: axdirectsql (46 rows)
INSERT INTO {schema}.axdirectsql (axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES
('99999999990013', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_actorlist', NULL, 'Metadata', '5', 'select actorname as displaydata from axpdef_peg_actor', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990028', 'F', '0', NULL, 'admin', '2026-01-30 00:00:00', 'admin', '2026-01-30 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'axi_adscolumnlist', NULL, 'Metadata', '0', 'select b.fldcaption || ''(''||b.fldname||'')'' displaydata,b.fldname name,b.fldcaption caption,b.normalized,b.fdatatype, b.sourcetable,b.sourcefld , CASE WHEN lower(sqltext) LIKE ''%--axp_filter%'' THEN ''T'' ELSE ''F'' END AS filters from axdirectsql a left join axdirectsql_metadata b on a.axdirectsqlid =b.axdirectsqlid where sqlname = :param1', 'param1', 'param1~Character~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990030', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_adsdropdowntokens', NULL, 'Metadata', '5', 'select * from get_ads_dropdown_data(:param1,:param2)', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990027', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_adsfilteroperators', NULL, 'Metadata', '5', 'SELECT ''='' AS displaydata, ''='' AS name UNION ALL SELECT ''<'',''<'' UNION ALL SELECT ''>'',''>'' UNION ALL SELECT ''<='',''<='' UNION ALL SELECT ''>='',''>='' UNION ALL SELECT ''between'',''between''', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990032', 'F', '0', NULL, 'admin', '2025-12-24 19:34:05', 'admin', '2025-12-24 19:34:05', NULL, '1', '1', NULL, NULL, NULL, 'axi_analyticslist', NULL, 'Metadata', '5', 'SELECT t.caption || '' ('' || t.name || '')'' AS displaydata,t.caption,t.name FROM tstructs t JOIN ax_userconfigdata u ON t.name = ANY (string_to_array(u.value, '','')) WHERE Upper(u.page) = ''ANALYTICS'' and Upper(u.keyname) = ''ENTITIES'' AND (u.username = :param1 OR u.username = ''All'')', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990014', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_cardlist', NULL, 'Metadata', '5', 'select cardname as displaydata from axp_cards', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990019', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_dimensionlist', NULL, 'Metadata', '5', 'select grpnamedb as displaydata from AxGrouping', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990029', 'F', '0', NULL, 'admin', '2025-12-23 13:35:16', 'admin', '2025-12-22 16:01:14', NULL, '1', '1', NULL, NULL, NULL, 'axi_fieldlist', NULL, 'Metadata', '5', 'select caption||'' (''||fname||'')'' displaydata, caption, fname name, tstruct,substring(modeofentry,1,1) moe,"datatype",fldsql,dcname,asgrid,listvalues fromlist,srckey normalized from axpflds where tstruct = :param1 and dcname = ''dc1'' and hidden = ''F'' and modeofentry in (''accept'',''select'')and savevalue = ''T'' and "datatype" <> ''i'' order by ordno asc', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990024', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_fieldvalueswithkeysuffixlist', NULL, 'Metadata', '5', 'select * from fn_axi_get_fieldvalues_with_keysuffix_list(:param1, :param2);', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990033', 'F', '0', NULL, 'admin', '2025-12-23 20:50:43', 'admin', '2025-12-23 20:50:43', NULL, '1', '1', NULL, NULL, NULL, 'axi_firesql', NULL, 'Metadata', '5', 'select * from axi_firesql_v2(:param1,:param2,:param3,:param4)', 'param1,param2,param3,param4', 'param1~~,param2~~,param3~~,param4~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990025', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_keyvalueswithfieldnameslist', NULL, 'Metadata', '5', 'select * from  fn_axi_getkeyvalueswithfieldnameslist( :param1 , :param2);', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990020', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_pagelist', NULL, 'Metadata', '5', 'select caption as displaydata,props as requesturl from axpages where pagetype = ''web''', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990012', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_peglist', NULL, 'Metadata', '5', 'select caption as displaydata from axpdef_peg_processmaster', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990015', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_printformlist', NULL, 'Metadata', '5', 'select template_name as displaydata from ax_configure_fast_prints', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990018', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_rolelist', NULL, 'Metadata', '5', 'select groupname as displaydata from axusergroups', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990016', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_servernamelist', NULL, 'Metadata', '5', 'select servername as displaydata from dwb_publishprops', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990031', 'F', '0', NULL, 'admin', '2025-12-23 13:35:16', 'admin', '2025-12-22 16:01:14', NULL, '1', '1', NULL, NULL, NULL, 'axi_setfieldlist', NULL, 'Metadata', '5', 'select caption||'' (''||fname||'')'' displaydata, caption, fname name, tstruct,substring(modeofentry,1,1) moe,"datatype",fldsql sql from axpflds where tstruct = :param1 and dcname = ''dc1'' and hidden = ''F'' and savevalue = ''T'' and modeofentry in (''accept'',''select'') and "datatype" <> ''i'' order by ordno asc', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990023', 'F', '0', NULL, 'admin', '2026-01-30 00:00:00', 'admin', '2026-01-30 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'axi_smartlist_ads_metadata', NULL, 'Metadata', '0', 'select a.sqlname,a.sqltext,a.sqlparams, a.sqlquerycols,a.encryptedflds,a.cachedata,a.cacheinterval, b.fldname,b.fldcaption,b."normalized" ,b.sourcetable ,b.sourcefld ,hyp_structtype,b.hyp_transid, b.tbl_hyperlink, CASE WHEN lower(sqltext) LIKE ''%--axp_filter%'' THEN ''T'' ELSE ''F'' END AS filters from axdirectsql a left join axdirectsql_metadata b on a.axdirectsqlid =b.axdirectsqlid where sqlname = :adsname', 'adsname', 'adsname~Character~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990026', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_tstructprops_insupd', NULL, 'Metadata', '5', 'select * from fn_upsert_config_by_condition(:param1,:param2,:param3,:param4)', 'param1,param2,param3,param4', 'param1~~,param2~~,param3~~,param4~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990017', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_usergrouplist', NULL, 'Metadata', '5', 'select users_group_name as displaydata from axpdef_usergroups', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990034', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_userpwd', NULL, 'Metadata', '5', 'select password  from axusers where username = :param1', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990022', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_viewlist', NULL, 'Metadata', '5', 'select * from (select caption||'' (''||name||'')'' || '' [tstruct]'' displaydata , caption, name from tstructs union select caption||'' (''||name||'')'' || '' [iview]'' displaydata, caption, name from iviews union select caption|| '' [page]'' as displaydata ,caption, props name from axpages where pagetype = ''web'' and (props is not null and props <> '''') union select sqlname||'' (''||sqlsrc||'')'' || '' [ads]'' displaydata, sqlsrc caption, sqlname name from axdirectsql union select ''Inbox'' displaydata,''Inbox'' caption,''Inbox'' name from dual) src order by displaydata asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('1414440000000', 'F', '0', NULL, 'admin', '2023-10-26 10:52:09', 'admin', '2023-10-26 10:52:09', NULL, '1', '1', NULL, NULL, NULL, 'Text_Field_Intelligence', NULL, 'Metadata', '1', 'select id,caption,source from(
select fname id,caption,''Form'' source,2 ord from axpflds where asgrid=''F'' and tstruct = :txttransid 
union all
select db_varname,db_varcaption,''Axvars'' ,3 ord from axpdef_axvars_dbvar a,axpdef_axvars b
where b.axpdef_axvarsid=a.axpdef_axvarsid 
union all
select regexp_split_to_table(''username,usergroup'','',''),regexp_split_to_table(''Login username,User role'','',''),''App vars'' ,4 ord from dual
union all
select fname,caption,''Glovar'',5 ord from axpflds where tstruct=''axglo''
order by 4,1)a', 'txttransid', 'txttransid', 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('1569990000000', 'F', '0', NULL, 'admin', '2023-11-07 17:12:21', 'admin', '2023-11-07 17:12:21', NULL, '1', '1', NULL, NULL, NULL, 'axcalendarsource', NULL, 'Internal', '1', 'select * from vw_cards_calendar_data where mapname is null and uname = :username order by startdate', 'username', 'username', 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('99999999990008', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_iviewlist', NULL, 'Metadata', '5', 'select caption||'' (''||name||'')'' displaydata, caption, name from Iviews', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990001', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_jobnameslist', NULL, 'Metadata', '5', 'select jname as displaydata from axpdef_jobs', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('1473660000000', 'F', '0', NULL, 'admin', '2024-12-24 07:43:28', 'admin', '2024-12-24 07:43:28', NULL, '1', '1', NULL, NULL, NULL, 'ds_homepage_kpicards', NULL, 'Internal', '2', 'select ''Users'',count(*),''taxusr()'' link from axusers
union all
select ''Records created today'',count(*),null from axpertlog a 
where lower(servicename)=''saving data''
and cast(calledon as date)=current_date
and username =:username
union all 
select ''Active sessions'',count(*),null from axaudit a 
where cast(logintime as date)=current_date
and nologout =''T''
union all
select ''Sample with params'',0,''taxusr(pusername=admin~build=''T'') from dual where 1=2', 'username', 'username', 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('99999999990006', 'F', '0', NULL, 'admin', '2025-12-22 14:31:09', 'admin', '2025-12-20 16:20:58', NULL, '1', '1', NULL, NULL, NULL, 'axi_adslist', NULL, 'Metadata', '5', 'select sqlname||'' (''||sqlsrc||'')'' displaydata,sqlname name,sqlsrc  from axdirectsql a', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990021', 'F', '0', NULL, 'admin', '2025-12-23 13:35:16', 'admin', '2025-12-22 16:01:14', NULL, '1', '1', NULL, NULL, NULL, 'axi_keyfieldlist', NULL, 'Metadata', '5', 'SELECT keyfield FROM (SELECT keyfield, 1 AS priority, NULL AS modeofentry, NULL AS allowduplicate, NULL AS datatype, NULL AS ordno FROM axp_tstructprops WHERE name = :param1 UNION ALL SELECT fname AS keyfield, 2 AS priority, modeofentry, allowduplicate, datatype, ordno FROM axpflds WHERE tstruct = :param1 and dcname = ''dc1'' AND (modeofentry = ''autogenerate'' OR ((LOWER(allowduplicate) = ''f'' OR datatype = ''c'') AND LOWER(hidden) = ''f''))) t ORDER BY priority, CASE WHEN modeofentry = ''autogenerate'' THEN 1 WHEN LOWER(allowduplicate) = ''f'' THEN 2 WHEN datatype = ''c'' THEN 3 ELSE 4 END, ordno ASC LIMIT 1', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('1457330000000', 'F', '0', NULL, 'admin', '2026-02-17 00:00:00', 'admin', '2025-12-23 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'ds_getsmartlists', NULL, 'Metadata', '5', 'select sqlname from axdirectsql a where sqlsrc=''Application''', NULL, NULL, 'ALL', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1487110000002', 'F', '0', NULL, 'admin', '2026-02-12 00:00:00', 'admin', '2026-02-12 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'Axi_getmetadata', NULL, 'Metadata', '0', 'SELECT * from fn_axi_metadata( :pstructtype , :pusername )', 'pstructtype,pusername', 'pstructtype~Character~,pusername~Character~', 'ALL', NULL, 'structtype,caption,transid', 'F', '6 Hr', NULL, NULL, NULL),
('1487220000000', 'F', '0', NULL, 'admin', '2026-02-12 00:00:00', 'admin', '2026-02-12 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'Axi_metadata_struct_obj', NULL, 'Metadata', '0', 'SELECT * from fn_axi_struct_metadata( :pstructtype, :ptransid , :pobjtype )', 'pstructtype,ptransid,pobjtype', 'pstructtype~Character~,ptransid~Character~,pobjtype~Character~', 'ALL', NULL, 'objtype,objcaption,objname,dcname,asgrid', 'F', '6 Hr', NULL, NULL, NULL),
('1647330000001', 'F', '0', NULL, 'abinash', '2026-02-04 00:00:00', 'abinash', '2026-02-04 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'ds_smartlist_filters', NULL, 'Metadata', '0', 'SELECT * from fn_axpanalytics_filterdata( :ptransid, :psrctxt)', 'ptransid,psrctxt', 'ptransid~Character~,psrctxt~Character~', 'ALL', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1471440000000', 'F', '0', NULL, 'admin', '2026-02-04 00:00:00', 'admin', '2026-01-30 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'ds_smartlist_ads_metadata', NULL, 'Metadata', '0', 'select a.sqlname,b.fldname,b.fldcaption,b.fdatatype, b."normalized" ,b.sourcetable ,b.sourcefld ,hyp_structtype,b.hyp_transid, b.tbl_hyperlink,
case when smartlistcnd like ''%Dynamic select columns%'' then ''T'' else ''F'' end dynamiccolumns,
case when smartlistcnd like ''%Filter%'' then coalesce(b.filter,''No'') else ''F'' end filters,
case when smartlistcnd like ''%Pagination%'' then ''T'' else ''F'' end pagination,
case when smartlistcnd like ''%Sorting%'' then ''T'' else ''F'' end sorting
from axdirectsql a left join axdirectsql_metadata b on a.axdirectsqlid =b.axdirectsqlid 
where sqlname = :adsname
order by b.axdirectsql_metadatarow ', 'adsname', 'adsname~Character~', 'ALL', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1473550000000', 'F', '0', NULL, 'admin', '2024-12-24 07:33:03', 'admin', '2024-12-24 07:33:03', NULL, '1', '1', NULL, NULL, NULL, 'ds_homepage_recentactivities', NULL, 'Internal', '2', 'select * from 
(select case lower(servicename) 
when ''saving data'' then ''new data created in ''||t.caption 
when ''quick form load'' then t.caption ||'' opened''
when ''form load'' then t.caption ||'' opened''
when ''importdata''  then ''Data import''
when ''exportdata'' then ''Data export''
when ''deleting data'' then ''Data deleted in''||t.caption
when ''get iview new'' then i.caption||'' report opened''
when ''get iview'' then i.caption||'' report opened''
when ''logout'' then ''Logout''
when ''login'' then ''Login''
when ''get structure'' then t.caption ||'' opened''
when ''load data''  then ''Load data in ''||t.caption 
when ''quick load data'' then ''Load data in ''||t.caption 
end title,
username,calledon,
case when lower(servicename) in (''get iview new'',''get iview'') then ''i''||structname||''()'' 
when lower(servicename) in(''quick load data'',''load data'') then ''t''||structname||''(recordid=''||recordid||'')''
when lower(servicename) in(''get structure'',''quick form load'',''form load'',''deleting data'') then ''t''||structname||''()'' end link 
from axpertlog a 
left join tstructs t on a.structname = t."name" 
left join iviews i on a.structname = i."name" 
where lower(servicename) in (''load data'',''quick load data'',''form load'',''get structure'',''saving data'',''quick form load'',''importdata'',''exportdata'',''deleting data'',''get iview new'',''get iview'',''logout'',''login'')
and calledon > current_date - 2
and username = :username)a
where a.title is not null
order by calledon desc', 'username', 'username', 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('1473330000000', 'F', '0', NULL, 'admin', '2024-12-24 06:45:30', 'admin', '2024-12-24 06:45:30', NULL, '1', '1', NULL, NULL, NULL, 'ds_homepage_quicklinks', NULL, 'Internal', '2', 'SELECT distinct 
case when lower(servicename)=''get structure'' then t.caption
when lower(servicename) in(''get iview new'',''get iview'') then i.caption end caption,
case when lower(servicename)=''get structure'' then ''t''||structname||''()''
when lower(servicename) in(''get iview new'',''get iview'') then ''i''||structname||''()'' end link
from axpertlog a left join tstructs t on a.structname = t."name" 
left join iviews i on a.structname = i."name" 
where cast(calledon as date) > current_date - 1  
and lower(servicename) in(''get structure'',''get iview new'',''get iview'')
and structname is not null
and a.username  = :username', 'username', 'username', 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('1543220000000', 'F', '0', NULL, 'admin', '2025-02-06 00:00:00', 'admin', '2025-02-06 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'ds_homepage_banner', NULL, 'Internal', '2', 'SELECT ''Developer faster'' as title, ''Developer faster using Axpert low code platform.'' as subtitle, ''Jan 01, 2025'' as time, ''https://dev.agilecloud.biz/axpert11.3web/CustomPages/images/slider1.png'' as image, '''' as link from dual
union
SELECT ''UI Plugins'' as title, ''Use UI Plugins to enhance the user experience'' as subtitle, ''Jan 01, 2025'' as time, ''https://dev.agilecloud.biz/axpert11.3web/CustomPages/images/slider1.png'' as image, '''' as link from dual
union
SELECT ''Configure yourself'' as title, ''Configure functionalities as per customer needs'' as subtitle, ''Jan 01, 2025'' as time, ''https://dev.agilecloud.biz/axpert11.3web/CustomPages/images/slider1.png'' as image, '''' as link from dual
', NULL, NULL, 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('1473880000000', 'F', '0', NULL, 'admin', '2024-12-24 07:55:05', 'admin', '2024-12-24 07:55:05', NULL, '1', '1', NULL, NULL, NULL, 'ds_homepage_events', NULL, 'Internal', '2', 'select	title,subdetails subtitle,modifiedon ,''ta__na(recordid=''||axpdef_news_eventsid||'')'' link, ''images/news/$APP_NAME$/'' || img.recordid || ''.'' || img.ftype image
from axpdef_news_events a left join a__naeventimg img on img.recordid = a.axpdef_news_eventsid
where active=''T''
and  (current_date >= effectfrom and (effecto >= current_date or effecto is null))
group by title,subdetails ,modifiedon ,''ta__na(recordid=''||axpdef_news_eventsid||'')'' , ''images/news/$APP_NAME$/'' || img.recordid || ''.'' || img.ftype,a.effectfrom
order by effectfrom', 'username', 'username', 'ALL', NULL, NULL, 'T', '6 Hr', NULL, NULL, NULL),
('99999999990007', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_apinameslist', NULL, 'Metadata', '5', 'select execapidefname as displaydata from executeapidef', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990004', 'F', '0', NULL, 'admin', '2025-12-23 20:50:43', 'admin', '2025-12-23 20:50:43', NULL, '1', '1', NULL, NULL, NULL, 'axi_fieldvaluelist', NULL, 'Metadata', '5', 'SELECT * FROM get_dynamic_field(:param1, :param2) as displaydata;', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990002', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_formnotifylist', NULL, 'Metadata', '5', 'select form as displaydata,stransid name from axformnotify', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990009', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_pegnotifylist', NULL, 'Metadata', '5', 'select name as displaydata from axnotificationdef', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990010', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_rulenameslist', NULL, 'Metadata', '5', 'select rulename as displaydata from axpdef_ruleeng', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990011', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_schedulenotifylist', NULL, 'Metadata', '5', 'select name as displaydata from axperiodnotify', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990005', 'F', '0', NULL, 'admin', '2025-12-23 13:22:07', 'admin', '2025-12-19 16:06:57', NULL, '1', '1', NULL, NULL, NULL, 'axi_tstructlist', NULL, 'Metadata', '5', 'select caption||'' (''||name||'')'' displaydata, caption, name from tstructs', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL),
('99999999990003', 'F', '0', NULL, 'admin', '2025-12-24 19:34:05', 'admin', '2025-12-24 19:34:05', NULL, '1', '1', NULL, NULL, NULL, 'axi_userlist', NULL, 'Metadata', '5', 'select username as displaydata from axusers', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axdirectsql_metadata (0 rows)
-- No rows in source dump for axdirectsql_metadata.

-- Seed: axdsignconfig (0 rows)
-- No rows in source dump for axdsignconfig.

-- Seed: axdsignmail (0 rows)
-- No rows in source dump for axdsignmail.

-- Seed: axdsigntrans (0 rows)
-- No rows in source dump for axdsigntrans.

-- Seed: axentityrelations (13 rows)
INSERT INTO {schema}.axentityrelations (axentityrelationsid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, rtypeui, rtype, mstructui, mstruct, primarytable, mfieldui, mfield, mtable, dstructui, dstruct, dprimarytable, dfieldui, dfield, dtable, dupchk)
VALUES
('265', 'F', NULL, NULL, 'admin', '2026-02-27 16:47:22.153477', 'admin', '2026-02-27 16:47:22.153477', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'User role-(ad_ur)', 'ad_ur', 'axpdef_userroles', NULL, NULL, NULL, 'User Role-(axrol)', 'axrol', 'AXUSERGROUPS', NULL, 'sourceid', 'AXUSERGROUPS', NULL),
('266', 'F', NULL, NULL, 'admin', '2026-02-27 16:47:22.153477', 'admin', '2026-02-27 16:47:22.153477', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'User role-(ad_ur)', 'ad_ur', 'axpdef_userroles', NULL, NULL, NULL, 'User Role-(axrol)', 'axrol', 'AXUSERGROUPS', NULL, 'sourceid', 'AXUSERGROUPS', NULL),
('307', 'F', NULL, NULL, 'admin', '2026-02-27 20:10:44.316776', 'admin', '2026-02-27 20:10:44.316776', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Rule engine V3-(a__re)', 'a__re', 'axpdef_ruleeng', NULL, NULL, NULL, 'Axpert rule definition core-(ruldf)', 'ruldf', 'AxRulesDef', NULL, 'sourceid', 'AxRulesDef', NULL),
('308', 'F', NULL, NULL, 'admin', '2026-02-27 20:10:44.316776', 'admin', '2026-02-27 20:10:44.316776', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Rule engine V3-(a__re)', 'a__re', 'axpdef_ruleeng', NULL, NULL, NULL, 'Axpert rule definition core-(ruldf)', 'ruldf', 'AxRulesDef', NULL, 'sourceid', 'AxRulesDef', NULL),
('309', 'F', NULL, NULL, 'admin', '2026-02-27 20:10:44.316776', 'admin', '2026-02-27 20:10:44.316776', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Rule engine V3-(a__re)', 'a__re', 'axpdef_ruleeng', NULL, NULL, NULL, 'Axpert rule definition core-(ruldf)', 'ruldf', 'AxRulesDef', NULL, 'sourceid', 'AxRulesDef', NULL),
('310', 'F', NULL, NULL, 'admin', '2026-02-27 20:10:44.316776', 'admin', '2026-02-27 20:10:44.316776', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Rule engine V3-(a__re)', 'a__re', 'axpdef_ruleeng', NULL, NULL, NULL, 'Axpert rule definition core-(ruldf)', 'ruldf', 'AxRulesDef', NULL, 'sourceid', 'AxRulesDef', NULL),
('314', 'F', NULL, NULL, 'admin', '2026-02-28 09:52:59.805329', 'admin', '2026-02-28 09:52:59.805329', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'User Login-(axusr)', 'axusr', 'axusers', NULL, NULL, NULL, 'Global Parameters-(axglo)', 'axglo', 'AxGloVar', NULL, 'sourceid', 'AxGloVar', NULL),
('315', 'F', NULL, NULL, 'admin', '2026-02-28 09:52:59.805329', 'admin', '2026-02-28 09:52:59.805329', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'User Login-(axusr)', 'axusr', 'axusers', NULL, NULL, NULL, 'Global Parameters-(axglo)', 'axglo', 'AxGloVar', NULL, 'sourceid', 'AxGloVar', NULL),
('1244', 'F', NULL, NULL, 'admin', '2026-04-02 16:23:36.301534', 'admin', '2026-04-02 16:23:36.301534', NULL, '1', '1', NULL, NULL, NULL, 'Dropdown', 'md', 'Dimension-(a_pgm)', 'a_pgm', 'axgroupingmst', 'Caption*-(grpcaption)', 'grpcaption', 'axgroupingmst', 'Dimension and value-(a__ag)', 'a__ag', 'AxGrouping', 'Dimension*-(grpname)', 'grpname', 'AxGrouping', NULL),
('189', 'F', NULL, NULL, 'admin', '2025-09-10 12:13:55.44795', 'admin', '2025-09-10 12:13:55.44795', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Application Constants and Variables-(axvar)', 'axvar', 'axp_vp', NULL, NULL, NULL, 'Axvar data library-(ad_vc)', 'ad_vc', 'axvarcore', NULL, 'sourceid', 'axvarcore', NULL),
('190', 'F', NULL, NULL, 'admin', '2025-09-10 12:13:55.44795', 'admin', '2025-09-10 12:13:55.44795', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Application Constants and Variables-(axvar)', 'axvar', 'axp_vp', NULL, NULL, NULL, 'Axvar data library-(ad_vc)', 'ad_vc', 'axvarcore', NULL, 'sourceid', 'axvarcore', NULL),
('191', 'F', NULL, NULL, 'admin', '2025-09-10 12:13:55.44795', 'admin', '2025-09-10 12:13:55.44795', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Application Constants and Variables-(axvar)', 'axvar', 'axp_vp', NULL, NULL, NULL, 'Axvar data library-(ad_vc)', 'ad_vc', 'axvarcore', NULL, 'sourceid', 'axvarcore', NULL),
('192', 'F', NULL, NULL, 'admin', '2025-09-10 12:13:55.44795', 'admin', '2025-09-10 12:13:55.44795', NULL, '1', '1', NULL, NULL, NULL, 'Genmap', 'gm', 'Application Constants and Variables-(axvar)', 'axvar', 'axp_vp', NULL, NULL, NULL, 'Axvar data library-(ad_vc)', 'ad_vc', 'axvarcore', NULL, 'sourceid', 'axvarcore', NULL)
ON CONFLICT DO NOTHING;

-- Seed: axerrorlog (0 rows)
-- No rows in source dump for axerrorlog.

-- Seed: axexportjobs (0 rows)
-- No rows in source dump for axexportjobs.

-- Seed: axexportjobsexception (0 rows)
-- No rows in source dump for axexportjobsexception.

-- Seed: axfastlink (0 rows)
-- No rows in source dump for axfastlink.

-- Seed: axfinworkflow (0 rows)
-- No rows in source dump for axfinworkflow.

-- Seed: axformnotify (0 rows)
-- No rows in source dump for axformnotify.

-- Seed: axglovar (1 rows)
INSERT INTO {schema}.axglovar (axglovarid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, fromuserlogin, axglo_user, axp_displaytext, axglo_hide, axpimageserver, axpimagepath)
VALUES
('1002550000002', 'F', '1', 'axusr1', 'admin', '2026-02-28 10:53:41', 'admin', '2025-11-12 10:30:05', NULL, '1', '1', NULL, NULL, NULL, 'F', 'admin', NULL, 'T', NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axgraphcols (0 rows)
-- No rows in source dump for axgraphcols.

-- Seed: axgraphsetting (0 rows)
-- No rows in source dump for axgraphsetting.

-- Seed: axgrouping (0 rows)
-- No rows in source dump for axgrouping.

-- Seed: axgroupingmst (0 rows)
-- No rows in source dump for axgroupingmst.

-- Seed: axgrouptstructs (0 rows)
-- No rows in source dump for axgrouptstructs.

-- Seed: axi_command_prompts (22 rows)
INSERT INTO {schema}.axi_command_prompts (id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES
('b767f878-6f6f-4d72-8a52-f987d5dc9064', '1', '2', 'tstruct name', 'Axi_TStructList', NULL, NULL, NULL, NULL, NULL),
('b678f938-6f7f-4d72-8a78-f987d5dc8780', '1', '3', 'with values', '', '', 'with', NULL, NULL, NULL),
('b767f938-6f7f-4d72-8a78-f987d5dc9678', '1', '4', 'field name', 'Axi_FieldList', '2', NULL, NULL, NULL, NULL),
('8faae04b-af25-4be7-b97c-de72815255f4', '2', '2', 'tstruct name', 'Axi_TStructList', NULL, NULL, NULL, NULL, NULL),
('29ce28d9-72f1-41ff-b872-faf9107774b6', '2', '3', 'search value', 'Axi_KeyValuesWithFieldNamesList', '2', NULL, NULL, 'axi_keyfieldlist', NULL),
('8faae04b-af25-4be7-b97c-de72815267f5', '2', '4', 'object name', 'Axi_FieldValuesWithKeySuffixList', '2,3', NULL, NULL, '', NULL),
('7faae15b-af25-4be7-b86c-de73925267f5', '2', '5', 'with values', '', '', 'with', NULL, '', NULL),
('b878f939-6f7f-4d72-8a78-f912d5dc9669', '2', '6', 'field name', 'Axi_FieldList', '2', NULL, NULL, NULL, NULL),
('46647ef0-f107-4551-8379-3b844d430016', '3', '2', 'object name', 'Axi_ViewList', NULL, 'tstruct,iview,ads,page', NULL, '', NULL),
('46d7bb0e-12e4-4249-b508-f9e824717957', '3', '3', 'search value', 'Axi_KeyValuesWithFieldNamesList,axi_dummylist,axi_adscolumnlist,axi_dummylist', '2', NULL, NULL, 'axi_keyfieldlist', NULL),
('8faae09b-af52-4be8-b97c-de72815276f4', '3', '4', 'object name', 'Axi_FieldValuesWithKeySuffixList', '2,3', NULL, NULL, NULL, NULL),
('10655119-ba93-42e8-8aef-0aefccae5a80', '4', '2', 'object type', '', NULL, 'peg,formnotification,schdulednotification,pegformnotification,job,printform,api,rule,properties,permission,access,server,keyfield', NULL, NULL, NULL),
('0f99d918-0caa-4523-9260-f18b5bd162bf', '4', '3', 'object name', 'Axi_PegList,Axi_FormNotifyList,Axi_ScheduleNotifyList,Axi_PEGNotifyList,Axi_JobNamesList,Axi_PrintFormList,Axi_APINamesList,Axi_RuleNamesList,Axi_Dummy,axi_userlist,axi_rolelist,Axi_ServernameList,Axi_TStructList', NULL, '', NULL, NULL, NULL),
('0f67d918-0caa-4523-9260-f18b5bd982fb', '4', '4', 'key field', 'Axi_FieldList', '3', '', NULL, NULL, NULL),
('b148e471-7ace-49e7-a7ab-16d3338908cf', '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('3ddb84e6-6e76-48c8-8dd5-4d46fc4f9542', '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('369efe5f-7e05-4b00-b2fd-10fae4bd3f72', '7', '2', 'type', NULL, NULL, 'tstruct,iview,ads,page,card,devoption,appvar,dbconsole,packager', NULL, NULL, NULL),
('4aa86d11-a357-4ba1-ab1d-b4251676ba8f', '7', '3', 'name', 'Axi_TStructList,Axi_IViewList,Axi_AdsList,Axi_PageList,Axi_CardList,,Axi_Dummy,,Axi_Dummy,,Axi_Dummy,,Axi_Dummy,,Axi_Dummy', NULL, NULL, NULL, NULL, NULL),
('8fbbe05b-af25-4be7-b97c-de71825267f6', '8', '2', 'field name', 'Axi_SetFieldList', NULL, NULL, NULL, ':transid', NULL),
('8fbbe05b-af25-4be7-b97c-de71825267f7', '10', '2', 'entity name', 'Axi_AnalyticsList', NULL, NULL, NULL, ':username', NULL),
('8fbbe05b-af25-4be7-b89c-de71825278f8', '10', '3', 'group by', 'axi_fieldlist', '2', NULL, NULL, '', NULL),
('c6b1f464-95ef-4f87-93e0-4b78b44da6c9', '11', '2', 'name', NULL, NULL, 'start', NULL, NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axi_commands (6 rows)
INSERT INTO {schema}.axi_commands (cmdtoken, command_group, command)
VALUES
('1', 'create', ''),
('2', 'edit', ''),
('3', 'view', ''),
('4', 'configure', ''),
('5', 'upload', ''),
('6', 'download', '')
ON CONFLICT DO NOTHING;

-- Seed: axiconmenu (0 rows)
-- No rows in source dump for axiconmenu.

-- Seed: aximpappping (0 rows)
-- No rows in source dump for aximpappping.

-- Seed: aximpdatauploadjobs (0 rows)
-- No rows in source dump for aximpdatauploadjobs.

-- Seed: aximpdef (1 rows)
INSERT INTO {schema}.aximpdef (aximpdefid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, aximpdefname, aximpform, aximptransid, aximptextqualifier, aximpmapinfile, aximpheaderrows, aximpprimayfield, aximpgroupfield, aximpfieldseperatorui, aximpfieldseperator, aximpmapfields, aximpthreadcount, aximpprocname, aximpbindtotstruct, aximpstdcolumnwidth, aximpignorefldexception, aximponlyappend, aximpprocessmode, aximpfilefromtable, aximpprimaryfield_details)
VALUES
('1783010000000', 'F', '0', NULL, 'admin', '2023-03-28 00:00:00', 'admin', '2023-03-24 00:00:00', NULL, '1', '1', NULL, NULL, NULL, 'Axlanguage', 'Axlanguage Data', 'ad_li', 'F', 'F', '1', '', 'compname', '(comma)', ',', 'dispname,sname,compname,compengcap,compcaption', '1', '', 'F', '0', 'F', 'F', 'Process with error (ALL)', 'F', NULL)
ON CONFLICT DO NOTHING;

-- Seed: aximpfailedrecords (0 rows)
-- No rows in source dump for aximpfailedrecords.

-- Seed: aximpjobs (0 rows)
-- No rows in source dump for aximpjobs.

-- Seed: aximportdef (0 rows)
-- No rows in source dump for aximportdef.

-- Seed: aximportjobs (0 rows)
-- No rows in source dump for aximportjobs.

-- Seed: axinqueues (0 rows)
-- No rows in source dump for axinqueues.

-- Seed: axinqueuesdata (0 rows)
-- No rows in source dump for axinqueuesdata.

-- Seed: axivuserconfig (0 rows)
-- No rows in source dump for axivuserconfig.

-- Seed: axlangsource (0 rows)
-- No rows in source dump for axlangsource.

-- Seed: axlanguage (0 rows)
-- No rows in source dump for axlanguage.

-- Seed: axlanguage11x (0 rows)
-- No rows in source dump for axlanguage11x.

-- Seed: axliccontrol (0 rows)
-- No rows in source dump for axliccontrol.

-- Seed: axlictrans (0 rows)
-- No rows in source dump for axlictrans.

-- Seed: axlov (0 rows)
-- No rows in source dump for axlov.

-- Seed: axmaudit (0 rows)
-- No rows in source dump for axmaudit.

-- Seed: axmconnections (0 rows)
-- No rows in source dump for axmconnections.

-- Seed: axmessage (0 rows)
-- No rows in source dump for axmessage.

-- Seed: axmessage_archive (0 rows)
-- No rows in source dump for axmessage_archive.

-- Seed: axmmetadatamaster (3 rows)
INSERT INTO {schema}.axmmetadatamaster (structtype, structname, structcaption, structstatus, ordno, createdon, updatedon, createdby, updatedby)
VALUES
('iview', 'axroles', 'User Roles', 'prepare', NULL, '2015-07-21 00:00:00', '2016-02-19 00:00:00', 'admin', 'admin'),
('iview', 'testivie', 'Test Iview', 'ready', NULL, '2026-03-03 15:55:16.110957', '2026-03-03 15:55:16.110957', 'admin', 'admin'),
('tstruct', 'testf', 'Test form', 'ready', NULL, '2026-03-03 15:53:20.523519', '2026-03-03 00:00:00', 'admin', 'admin')
ON CONFLICT DO NOTHING;

-- Seed: axmtranscontrol (0 rows)
-- No rows in source dump for axmtranscontrol.

-- Seed: axmwslog (0 rows)
-- No rows in source dump for axmwslog.

-- Seed: axmyviews (0 rows)
-- No rows in source dump for axmyviews.

-- Seed: axnotificationdef (0 rows)
-- No rows in source dump for axnotificationdef.

-- Seed: axonlineconvlog (0 rows)
-- No rows in source dump for axonlineconvlog.

-- Seed: axoutqueues (0 rows)
-- No rows in source dump for axoutqueues.

-- Seed: axoutqueuesdata (0 rows)
-- No rows in source dump for axoutqueuesdata.

-- Seed: axoutqueuesmst (0 rows)
-- No rows in source dump for axoutqueuesmst.

-- Seed: axp__appmgrms1 (0 rows)
-- No rows in source dump for axp__appmgrms1.

-- Seed: axp__appmgrss1 (0 rows)
-- No rows in source dump for axp__appmgrss1.

-- Seed: axp_appmgr (0 rows)
-- No rows in source dump for axp_appmgr.

-- Seed: axp_appsearch_data (0 rows)
-- No rows in source dump for axp_appsearch_data.

-- Seed: axp_appsearch_data_period (0 rows)
-- No rows in source dump for axp_appsearch_data_period.

-- Seed: axp_appsearch_data_v2 (0 rows)
-- No rows in source dump for axp_appsearch_data_v2.

-- Seed: axp_appsearchdtl (0 rows)
-- No rows in source dump for axp_appsearchdtl.

-- Seed: axp_cards (6 rows)
INSERT INTO {schema}.axp_cards (axp_cardsid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, cardtypeui, cardtype, cardicon, charttype, sql_editor_cardsql, cardname, heightui, height, widthui, width, cachedata, autorefresh, orderno, clrpalet, trufalse, chartprops, accessstringui, chartjson, accessstring, axpfile_imgcard, con_name, pagecaption, axpfilepath_imgcard, pagename, cardbgclr, hcaption, isparentpage, htype, pagedesc, htranstypeui, htransid, is_migrated, html_editor_card, calendarsource, calendarstransid, dashboardcard, processcard, exp_editor_buttons, inchart, inhomepage, card_datasource, pluginname, indashboard)
VALUES
('1784550000000', 'F', '0', '', 'admin', '2026-02-28', 'admin', '2024-12-28', '', '1', '1', '0', '', '', 'chart|Chart||,kpi|KPI||,list|List||,menu|Menu card||,modern menu|Modern menu||,image card|Image card||,calendar|Calendar||,html|HTML Card||', 'Custom plugin', NULL, NULL, NULL, 'News & Events', '300', '300px', '30%', 'col-md-4', 'false', '0', '5', NULL, NULL, NULL, 'default', '{"attributes":{"cck":"","shwLgnd":,"xAxisL":"","yAxisL":"","gradClrChart":,"shwChartVal":,"threeD":"remove","enableSlick":,"numbSym":}}', ',default,', NULL, 'agileerpdemoaxdef', NULL, 'E:DemobizAxpertWebagileerpdemoImageCard*', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title mb-4">News & Events</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class="border-bottom" onclick="LoadIframe(''processflow.aspx?calendar=t'');">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
            </div>
        </div>
        <div class="card-body">
          <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
            <div class="row" id="eventsContainer">
                <!-- Dynamic Events will be inserted here -->
            </div>
        </div>
    </div>

    <script>
        setTimeout(() => {
            var input = {
                name: "ds_homepage_events",
                sqlParams: {}
            };

            new EntityCommon().getDataFromDataSource(input, (result) => {
                var data = JSON.parse(JSON.parse(result).result.data[0].data_json);

                const container = document.getElementById(''eventsContainer'');

                // Function to calculate human-readable time difference
                function timeAgo(date) {
                    const now = new Date();
                    const eventDate = new Date(date);
                    const diffInSeconds = Math.floor((now - eventDate) / 1000);
                    const minutes = Math.floor(diffInSeconds / 60);
                    const hours = Math.floor(minutes / 60);
                    const days = Math.floor(hours / 24);
                    const weeks = Math.floor(days / 7);
                    const months = Math.floor(days / 30);

                    if (diffInSeconds < 60) return "Last updated just now";
                    if (minutes < 60) return `Last updated ${minutes} min${minutes > 1 ? "s" : ""} ago`;
                    if (hours < 24) return `Last updated ${hours} hour${hours > 1 ? "s" : ""} ago`;
                    if (days < 7) return `Last updated ${days} day${days > 1 ? "s" : ""} ago`;
                    if (weeks < 4) return `Last updated ${weeks} week${weeks > 1 ? "s" : ""} ago`;
                    return `Last updated ${months} month${months > 1 ? "s" : ""} ago`;
                }

                data.forEach(event => {
                    const card = document.createElement(''div'');
                    card.className = ''col-lg-12 Events-items'';

                    card.innerHTML = `
                <div class="card">
                    <div class="row no-gutters align-items-center">
                        <div class="col-md-3">
                            <img class="card-img img-fluid" alt="Card image" src="${event.image}">
                        </div>
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <a href="#" class="text-decoration-none" onclick="navigateToUrl(''${event.link}'')">${event.title}</a>
                                </h5>
                                <p class="card-text">${event.subtitle}</p>
                                <p class="card-text"><small class="text-muted">${timeAgo(event.time)}</small></p>
                            </div>
                        </div>
                    </div>
                </div>
            `;

                    container.appendChild(card);
                });
              
              $("#eventsContainer").parent().find(".placeholder-content").addClass("d-none");

            }, () => {
                //Error callback
            })

        }, 1)

    </script>
</div>', '', '', NULL, NULL, '', NULL, 'T', 'ds_homepage_events', 'News Card', 'F'),
('1784660000000', 'F', '0', '', 'admin', '2026-02-28', 'admin', '2024-12-28', '', '1', '1', '0', '', '', 'chart|Chart||,kpi|KPI||,list|List||,menu|Menu card||,modern menu|Modern menu||,image card|Image card||,calendar|Calendar||,html|HTML Card||', 'Custom plugin', NULL, NULL, NULL, 'Recent Activities', '300', '300px', '30%', 'col-md-4', 'false', '0', '6', NULL, NULL, NULL, 'default', '{"attributes":{"cck":"","shwLgnd":,"xAxisL":"","yAxisL":"","gradClrChart":,"shwChartVal":,"threeD":"remove","enableSlick":,"numbSym":}}', ',default,', NULL, 'agileerpdemoaxdef', NULL, 'E:DemobizAxpertWebagileerpdemoImageCard*', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title mb-4">Recent Activities </h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class="d-none">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
            </div>
        </div>
        <div class="card-body">
          <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
            <ul class="verti-timeline list-unstyled" id="activitylist">
            </ul>
        </div>
    </div>

    <script>
        setTimeout(() => {

            var input = {
                name: "ds_homepage_recentactivities",
                sqlParams: {}
            };

            new EntityCommon().getDataFromDataSource(input, (result) => {
                var data = JSON.parse(JSON.parse(result).result.data[0].data_json);

                const activityList = document.getElementById(''activitylist'');

                // Convert timestamp to a human-readable format
                function timeAgo(timestamp) {
                    const now = new Date();
                    const date = new Date(timestamp);
                    const secondsAgo = Math.floor((now - date) / 1000);

                    const minutes = Math.floor(secondsAgo / 60);
                    const hours = Math.floor(minutes / 60);
                    const days = Math.floor(hours / 24);
                    const weeks = Math.floor(days / 7);
                    const months = Math.floor(days / 30);

                    if (secondsAgo < 60) return "Just now";
                    if (minutes < 60) return `${minutes} min ago`;
                    if (hours < 24) return `${hours} hrs ago`;
                    if (days < 7) return `${days} day${days > 1 ? ''s'' : ''''} ago`;
                    if (weeks < 4) return `${weeks} week${weeks > 1 ? ''s'' : ''''} ago`;
                    return `${months} month${months > 1 ? ''s'' : ''''} ago`;
                }

                // Extract initials (2 letters max)
                function getInitials(text) {
                    return text
                        .split('' '')
                        .map(word => word[0].toUpperCase())
                        .slice(0, 2)
                        .join('''');
                }

                // Construct HTML for each activity
                data.forEach(activity => {
                    const li = document.createElement(''li'');
                    li.className = ''ractivity'';

                    li.innerHTML = `
        <div class="ractivity-timeline-dot">
            <span class="material-icons material-icons-style material-icons-2">
                arrow_right
            </span>
        </div>
        <div class="d-flex">
            <div class="thumbnail-icon">
                <div class="symbol symbol-circle symbol-25px">
                    <div class="symbol-label bg-primary">
                        <span class="fs-7 text-inverse-primary">
                            ${getInitials(activity.title || activity.username)}
                        </span>
                    </div>
                </div>
            </div>
            <div class="flex-grow-1 d-flex">
                <div class="ractivity-desc">
                    ${activity.title}
                   
                    <p class="text-muted mb-0">${timeAgo(activity.calledon)}</p>
                </div>
                 ${activity.link ? `<a href="#" class="border-bottom ms-auto" onclick="navigateToUrl(''${activity.link}'')">View Details</a>` : ''''}
            </div>
        </div>
        `;

                    activityList.appendChild(li);
					$("#activitylist").parent().find(".placeholder-content").addClass("d-none");
                });

        
              $("#activitylist").parent().find(".placeholder-content").addClass("d-none");
              
            }, () => {
                //Error callback
            })

        }, 1)
    </script>
</div>', '', '', NULL, NULL, '', NULL, 'T', 'ds_homepage_recentactivities', 'Activity List', 'F'),
('1784440000000', 'F', '0', '', 'admin', '2025-09-09', 'admin', '2024-12-28', '', '1', '1', '0', '', '', 'chart|Chart||,kpi|KPI||,list|List||,menu|Menu card||,modern menu|Modern menu||,image card|Image card||,calendar|Calendar||,html|HTML Card||', 'html', NULL, NULL, NULL, 'Active List', '300', '300px', '30%', 'col-md-4', 'false', '0', '4', NULL, NULL, NULL, 'default', '{"attributes":{"cck":"","shwLgnd":,"xAxisL":"","yAxisL":"","gradClrChart":,"shwChartVal":,"threeD":"remove","enableSlick":,"numbSym":}}', ',default,', NULL, 'agileerpdemoaxdef', NULL, 'E:DemobizAxpertWebagileerpdemoImageCard*', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card active-list-wrapper">
        <div class="card-header pb-0">
            <h4 class="card-title mb-4">Active List</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class=" " onclick="LoadIframe(''processflow.aspx?activelist=t'');">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
            </div>

        </div>
        <div class="card-body" id="ActiveListcardbody">
      <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
      </div>
    </div>
    <script>
        setTimeout(function () {
            var input = {
                name: "ds_homepage_activelist",
                sqlParams: {}
            };

            new EntityCommon().getDataFromDataSource(input, (result) => {
                //Success callback
                var data = JSON.parse(JSON.parse(result).result.data[0].data_json)

                function getMaterialIconName(task) {
                    const taskIcons = {
                        "task-peg": "account_tree",
                        "task-make": "task",
                        "task-made": "task",
                        "task-approval": "fact_check",
                        "task-checked": "fact_check",
                        "task-approved": "task_alt",
                        "task-rejected": "scan_delete",
                        "task-returned": "source_notes",
                        "task-sent": "share_windows",
                        "task-escalation": "problem",
                        "task-reminder": "notifications_active",
                        "task-msg": "chat",
                        "task-excel export": "file_export",
                        "task-formnotification": "assignment_late"
                    };

                    return taskIcons[task] || "task";
                }

                function constructTaskStatusString(data) {
                    const parts = [];

                    if (data.taskstatus) {
                        parts.push(`task-${data.taskstatus}`);
                    } else if (data.tasktype) {
                        parts.push(`task-${data.tasktype}`);
                    }

                    return parts.join("")?.replaceAll(" ", "").toLowerCase() || "";
                }

                function constructTaskTypeString(data) {
                    const parts = [];

                    if (data.msgtype && data.msgtype.toLowerCase() != "na") {
                        parts.push(`task-msg`);
                    } else if (data.rectype) {
                        parts.push(`task-${data.rectype}`);
                    }

                    return parts.join("")?.replaceAll(" ", "").toLowerCase() || "";
                }
                const renderTimeFormat = (datetime) => {
                    const now = new Date();
                    const eventDate = new Date(datetime.replace(/(d+)/(d+)/(d+)/, ''$2/$1/$3'')); // Parse DD/MM/YYYY
                    const diffTime = Math.abs(now - eventDate);
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                    if (diffDays === 0) return "Today";
                    if (diffDays === 1) return "Yesterday";
                    if (diffDays <= 7) return "This Week";
                    if (diffDays <= 14) return "Last Week";
                    if (diffDays <= 30) return "Last Month";
                    return "Older";
                };

                const renderHTML = (item) => {

                    const displayTitle = item.displaytitle || "-";
                    const status = item.cstatus?.toLowerCase() || "";
                    const displayContent = item.displaycontent || "No Content";
                    const timeFormat = renderTimeFormat(item.eventdatetime);
                    const firstText = displayTitle.charAt(0).toUpperCase();
                    const taskClass = constructTaskStatusString(item);
                    const taskTypeClass = constructTaskTypeString(item);

                    var iconName = getMaterialIconName(taskClass || taskTypeClass || "") || "task";

                    return `
        <div class="listrow ${status} ${taskClass} ${taskTypeClass}">
            <div class="row">
                <div class="col-2 checkbox-wrapper">
                    <div class="symbol symbol-35px symbol-circle ${status} ${taskClass} ${taskTypeClass}">
                        <span class="symbol-label bg-danger text-white fs-6 fw-bolder"><span class="material-icons material-icons-style material-icons-2">${iconName}</span></span>
                    </div>
                </div>
                <div class="col-7">
                    <a href="javascript:void(0)" class="tasktitle border-bottom">${displayTitle}</a>
                    <div class="taskcontent">${displayContent}</div>
                </div>
                <div class="timespace col-3">
                    <div class="nametime">${timeFormat}</div>
                </div>
            </div>
        </div>
    `;
                };

                const container = document.querySelector("#ActiveListcardbody");
                data.forEach((item) => {
                    container.innerHTML += renderHTML(item);
                });
              
              $("#ActiveListcardbody").parent().find(".placeholder-content").addClass("d-none")

            }, () => {
                //Error callback
            })

        }, 1)

    </script>
</div>', '', '', NULL, NULL, '', NULL, 'F', NULL, NULL, NULL),
('1783770000000', 'F', '0', '', 'admin', '2026-02-28', 'admin', '2024-12-28', '', '1', '1', '0', '', '', 'chart|Chart||,kpi|KPI||,list|List||,menu|Menu card||,modern menu|Modern menu||,image card|Image card||,calendar|Calendar||,html|HTML Card||', 'Custom plugin', NULL, NULL, NULL, 'Quick Links', '300', '300px', '30%', 'col-md-4', 'false', '0', '2', NULL, NULL, NULL, 'default', '{"attributes":{"cck":"","shwLgnd":,"xAxisL":"","yAxisL":"","gradClrChart":,"shwChartVal":,"threeD":"remove","enableSlick":,"numbSym":}}', ',default,', NULL, 'agileerpdemoaxdef', NULL, 'E:DemobizAxpertWebagileerpdemoImageCard*', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title mb-4">Quick Links </h4>
            
        </div>
        <div class="card-body">
          <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
            <div class="HomePageMenuOptionCards mb-8 col-md-12"></div>
        </div>
    </div>

    <script>
        setTimeout(() => {
            var input = {
                name: "ds_homepage_quicklinks",
                sqlParams: {}
            };

            new EntityCommon().getDataFromDataSource(input, (result) => {
                var data = JSON.parse(JSON.parse(result).result.data[0].data_json);

                let generatedMenuOptionHTML = '''';
                data.forEach((rowData, index) => {
                    const moreOption = rowData.moreoption;
                    var stransid = rowData.stransid;
                    const rowCount = index;
                    rowData.rowCount = rowCount;

                    generatedMenuOptionHTML +=
                        `<div class="mt-3 widgetWrapper htmlDomWrapper col-lg-3 col-md-6 col-sm-12 col-xs-12" id="HP_cards_list" data-cardname="${rowData.name}">
        <div class="Home-cards-list">
            <div class="Hp-card-icon attendicon">
                <img class="w-60px cardsIcons" src="../images/homepageicon/${rowData.name}.png" onerror="this.onerror=null;this.src=''../images/homepageicon/default.png'';" onclick="navigateToUrl(''${rowData.link}'')">
            </div>
            <span class="Hp-card-title text-truncate" style="cursor:pointer" title="${rowData.name}" onclick="navigateToUrl(''${rowData.link}'')">${rowData.name}</span><p title="${rowData.name}" class="min-h-45px mh-45px multiline-ellipsis">${name}</p>                
        </div>
    </div>`;
                });

                if (generatedMenuOptionHTML != '''') {
                    let divOpen = `<div class=""><div class=""><div class="row d-flex">` + generatedMenuOptionHTML + `</div></div></div>`;
                    const tabContainer = document.querySelector(`.HomePageMenuOptionCards`);
                    tabContainer.innerHTML = divOpen;
                    $(".HomePageMenuOptionCards").parent().find(".placeholder-content").addClass("d-none")
                } else {
                    const tabContainer = document.querySelector(`.HomePageMenuOptionCards`);
                    tabContainer.classList.add("d-none");
                    $(".HomePageMenuOptionCards").parent().find(".placeholder-content").addClass("d-none")
                }
            }, () => {
                //Error callback
            })
        }, 1);

    </script>
</div>', '', '', NULL, NULL, '', NULL, 'T', 'ds_homepage_quicklinks', 'Menu icons', 'F'),
('1784010000000', 'F', '0', '', 'admin', '2026-02-28', 'admin', '2024-12-28', '', '1', '1', '0', '', '', 'chart|Chart||,kpi|KPI||,list|List||,menu|Menu card||,modern menu|Modern menu||,image card|Image card||,calendar|Calendar||,html|HTML Card||', 'Custom plugin', NULL, NULL, NULL, 'KPI', '300', '300px', '30%', 'col-md-4', 'false', '0', '3', NULL, NULL, NULL, 'default', '{"attributes":{"cck":"","shwLgnd":,"xAxisL":"","yAxisL":"","gradClrChart":,"shwChartVal":,"threeD":"remove","enableSlick":,"numbSym":}}', ',default,', NULL, 'agileerpdemoaxdef', NULL, 'E:DemobizAxpertWebagileerpdemoImageCard*', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card KPI-dashcards">
        <div class="card-header pb-0">
            <h4 class="card-title mb-4">KPI</h4>
            <div class="card-toolbar">
                <a href="#" data-bs-toggle="tooltip" class=" " onclick="LoadIframe(''processflow.aspx?dashboard=t'');">
                    <span class="material-icons material-icons-style material-icons-2">
                        open_in_new
                    </span>
                </a>
                <a href="#" data-bs-toggle="tooltip" class=" d-none" >
                    <span class="material-icons material-icons-style material-icons-2">
                        fullscreen
                    </span>
                </a>
            </div>

        </div>
        <div class="card-body">
          <div class="placeholder-content">
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
            <div class="placeholder-content_item"></div>
        </div>
            <div class="row" id="KPI_CardsList_Wrapper">
            </div>
        </div>
    </div>

    <script>
        setTimeout(() => {
            var input = {
                name: "ds_homepage_kpicards",
                sqlParams: {}
            };

            new EntityCommon().getDataFromDataSource(input, (result) => {
                var data = JSON.parse(JSON.parse(result).result.data[0].data_json);

                let generatedMenuOptionHTML = '''';
                data.forEach((rowData, index) => {
                    const moreOption = rowData.moreoption;
                    var stransid = rowData.stransid;
                    const rowCount = index;
                    rowData.rowCount = rowCount;

                    generatedMenuOptionHTML +=
                        `<div class=" widgetWrapper kpiWrapper " card-index="0">
                        <div class="card rounded-1 shadow-sm h-100 cardbg-${(index % 6) + 1}">
                            <!--begin::Card content wrapper-->
                            <div class="card-content-wrapper d-flex align-items-center">
                                <div class="card-title d-flex ">

                                    <div class="d-none mainIcon w-100--- me-2">
                                        <img alt="Icon" src="" class="mh-35px mw-35px">
                                    </div>

                                    <div class="symbol symbol-35px me-2 mainIcon">
                                        <div class="symbol-label cardbg-inverse-${(index % 6) + 1}">
                                            <div class="Invoice-icon" style="display: flex;">
                                                <span class="material-icons material-icons-style material-icons-2">bar_chart</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="Kpi-content">
                                        <span class="Kpi-caption mainHeading">${rowData.name}</span>
                                        <a href="#" onclick="navigateToUrl(''${rowData.link}'')">${rowData.value}</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Card Toolbar -->
                            <div class="card-toolbar d-flex justify-content-end d-none">
                                <a href="javascript:void(0);" class="btn btn-sm btn-flex btn-light-primary cardbg-3">
                                    <statuscontent></statuscontent>
                                </a>
                            </div>

                            <!-- Card Footer -->
                            <div class="card-footer border-0 d-none">
                                <div class="fs-7 fw-normal text-muted">
                                    <footercontent></footercontent>
                                </div>
                            </div>
                        </div>
                    </div>`;
                });

                document.querySelector(`#KPI_CardsList_Wrapper`).innerHTML = generatedMenuOptionHTML;
                $("#KPI_CardsList_Wrapper").parent().find(".placeholder-content").addClass("d-none")

            }, () => {
                //Error callback
            })

        }, 1)

    </script>
</div>', '', '', NULL, NULL, '', NULL, 'T', 'ds_homepage_kpicards', 'KPI List', 'F'),
('1783660000000', 'F', '0', '', 'admin', '2026-02-28', 'admin', '2024-12-28', '', '1', '1', '0', '', '', 'chart|Chart||,kpi|KPI||,list|List||,menu|Menu card||,modern menu|Modern menu||,image card|Image card||,calendar|Calendar||,html|HTML Card||', 'Custom plugin', NULL, NULL, NULL, 'Banner', '300', '300px', '30%', 'col-md-4', 'false', '0', '1', NULL, NULL, NULL, 'default', '{"attributes":{"cck":"","shwLgnd":,"xAxisL":"","yAxisL":"","gradClrChart":,"shwChartVal":,"threeD":"remove","enableSlick":,"numbSym":}}', ',default,', NULL, 'agileerpdemoaxdef', NULL, 'E:DemobizAxpertWebagileerpdemoImageCard*', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '<div data-shadowdom="false" class="dasboard-cards">
    <div class="card welcome-card">
        <div class="WelcomeCard-Wrapper">
            <img class="DashSliser-img" alt=""
                src="https://dev.agilecloud.biz/axpert11.3web/CustomPages/images/slider1.png">
            <div id="Dashboard_Slider" class="carousel carousel-custom carousel-stretch slide" data-bs-ride="carousel"
                data-bs-interval="8000"></div>
        </div>
    </div>

    <script>
        setTimeout(() => {
            const carouselData = {
                "carouselId": "Dashboard_Slider",
                "title": "Daily Quotes",
                "interval": 8000,
                "slides": [
                    {
                        "title": "Developer faster",
                        "description": "Developer faster using Axpert low code platform.",
                        "date": "Jan 01, 2025",
                        "isActive": true
                    },
                    {
                        "title": "UI Plugins",
                        "description": "Use UI Plugins to enhance the user experience",
                        "date": "Jan 01, 2025",
                        "isActive": false
                    },
                    {
                        "title": "Configure yourself",
                        "description": "Configure functionalities as per customer needs",
                        "date": "Jan 01, 2025",
                        "isActive": false
                    }
                ]
            };

            // Create HTML dynamically
            const container = document.getElementById(carouselData.carouselId);

            // Heading Section
            const headingHtml = `
        <div class="d-flex flex-stack align-items-center flex-wrap">
          <h4 class="SliderHeading">${carouselData.title}</h4>
          <ol class="p-0 m-0 carousel-indicators carousel-indicators-dots">
            ${carouselData.slides
                    .map(
                        (slide, index) => `
                <li data-bs-target="#${carouselData.carouselId}" data-bs-slide-to="${index}" class="ms-1 ${slide.isActive ? "active" : ""
                            }" ${slide.isActive ? ''aria-current="true"'' : ""}></li>`
                    )
                    .join("")}
          </ol>
        </div>`;
            container.innerHTML += headingHtml;

            // Carousel Inner
            const innerHtml = `
        <div class="carousel-inner pt-6">
          ${carouselData.slides
                    .map(
                        (slide) => `
              <div class="carousel-item ${slide.isActive ? "active" : ""}">
                <div class="carousel-wrapper">
                  <div class="d-flex flex-column flex-grow-1">
                    <a href="#" class="Slider-Title border-bottom">${slide.title}</a>
                    <p class="text-gray-600 fs-6 fw-semibold pt-3 mb-0">${slide.description}</p>
                  </div>
                  <div class="d-flex flex-stack pt-8">
                    <span class="badge badge-light-primary fs-7 fw-bold me-2">${slide.date}</span>
                  </div>
                </div>
              </div>`
                    )
                    .join("")}
        </div>`;
            container.innerHTML += innerHtml;
        }, 1);
    </script>
</div>', '', '', NULL, NULL, '', NULL, 'T', 'ds_homepage_events', 'Banner card', 'F')
ON CONFLICT DO NOTHING;

-- Seed: axp_customdatatype (0 rows)
-- No rows in source dump for axp_customdatatype.

-- Seed: axp_customtypes (0 rows)
-- No rows in source dump for axp_customtypes.

-- Seed: axp_dbwdetails (0 rows)
-- No rows in source dump for axp_dbwdetails.

-- Seed: axp_dependent (0 rows)
-- No rows in source dump for axp_dependent.

-- Seed: axp_files (0 rows)
-- No rows in source dump for axp_files.

-- Seed: axp_formload (0 rows)
-- No rows in source dump for axp_formload.

-- Seed: axp_mailjobs (0 rows)
-- No rows in source dump for axp_mailjobs.

-- Seed: axp_params (0 rows)
-- No rows in source dump for axp_params.

-- Seed: axp_reportjobs (0 rows)
-- No rows in source dump for axp_reportjobs.

-- Seed: axp_sales_data (0 rows)
-- No rows in source dump for axp_sales_data.

-- Seed: axp_smartviews_config (0 rows)
-- No rows in source dump for axp_smartviews_config.

-- Seed: axp_struct_release_log (0 rows)
-- No rows in source dump for axp_struct_release_log.

-- Seed: axp_tabledescriptor (0 rows)
-- No rows in source dump for axp_tabledescriptor.

-- Seed: axp_transcheck (0 rows)
-- No rows in source dump for axp_transcheck.

-- Seed: axp_tstructprops (0 rows)
-- No rows in source dump for axp_tstructprops.

-- Seed: axp_versionchangedetails (0 rows)
-- No rows in source dump for axp_versionchangedetails.

-- Seed: axp_versionchanges (0 rows)
-- No rows in source dump for axp_versionchanges.

-- Seed: axp_versions (0 rows)
-- No rows in source dump for axp_versions.

-- Seed: axp_vp (8 rows)
INSERT INTO {schema}.axp_vp (axp_vpid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, isconstant, isvariable, isappparam, vpname, isparam, vscript, pcaption, pdatatype, modeofentry, masterdlui, masterdl, source, sql_editor_psql, vpvalue, display, readonly, postaccept, postselect, customdatatype, datawidth, ttransid, dcselect, remarks, masterdlselect)
VALUES
('1489990000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxpDbDirPath', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1490770000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxFCMSendMsgURL', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1490990000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxMailFrom', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1491110000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxPEGMailFrom', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1491330000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'axpegemailactionurl', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1491660000002', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxScriptsAPIURL', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1491880000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxSignalRapiURL', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL),
('1492010000000', 'F', '0', NULL, 'admin', '2025-01-02 00:00:00', 'admin', '2025-01-02 00:00:00', NULL, '1', '1', '0', NULL, NULL, 'T', 'F', 'F', 'AxRMQAPIURL', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 'F', 'F', 'F', 'F', NULL, '10', 'axglo', 'Global Parameters(dc1)', NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axp_webtrace (0 rows)
-- No rows in source dump for axp_webtrace.

-- Seed: axpagedetail (86 rows)
INSERT INTO {schema}.axpagedetail (name, sname, stype)
VALUES
('PageTsad_db', 'ad_db', 't'),
('PageTsaxstc', 'axstc', 't'),
('PageTsaxfsc', 'axfsc', 't'),
('PageTserrcd', 'errcd', 't'),
('PageTsaxftp', 'axftp', 't'),
('PageTsthelp', 'thelp', 't'),
('PageTstemps', 'temps', 't'),
('PageTstconf', 'tconf', 't'),
('PageTsofcon', 'ofcon', 't'),
('PageTsiconf', 'iconf', 't'),
('PageTsaxctx', 'axctx', 't'),
('PageTsastcp', 'astcp', 't'),
('PageTsappsr', 'appsr', 't'),
('PageTsagspr', 'agspr', 't'),
('PageIvthint', 'thint', 'i'),
('PageIvsmslog', 'smslog', 'i'),
('PageIvloview1', 'loview1', 'i'),
('PageIvivhelpto', 'ivhelpto', 'i'),
('PageIvitimtk', 'itimtk', 'i'),
('PageIvimobc', 'imobc', 'i'),
('PageIvikywd', 'ikywd', 'i'),
('PageIvidsco', 'idsco', 'i'),
('PageIviaxpscon', 'iaxpscon', 'i'),
('PageIviaxex', 'iaxex', 'i'),
('PageIvesmsco', 'esmsco', 'i'),
('PageIvdmlscrpt', 'dmlscrpt', 'i'),
('PageIvcerrm', 'cerrm', 'i'),
('PageIvaxusracc', 'axusracc', 'i'),
('PageIvaxusers', 'axusers', 'i'),
('PageIvaxroles', 'axroles', 'i'),
('PageIvaxnxtlst', 'axnxtlst', 'i'),
('PageIvaxfinyrs', 'axfinyrs', 'i'),
('PageIvaxemllog', 'axemllog', 'i'),
('PageIvaxchtdtl', 'axchtdtl', 'i'),
('PageIvauditlog', 'auditlog', 'i'),
('PageIvapplogsm', 'applogsm', 'i'),
('PageIvadxoutlo', 'adxoutlo', 'i'),
('PageIvadxinlog', 'adxinlog', 'i'),
('Page245', 'axmme', 't'),
('PageTsad_db', 'ad_db', 't'),
('PageTsaxstc', 'axstc', 't'),
('PageTsaxfsc', 'axfsc', 't'),
('PageTserrcd', 'errcd', 't'),
('PageTsaxftp', 'axftp', 't'),
('PageTsthelp', 'thelp', 't'),
('PageTstemps', 'temps', 't'),
('PageTstconf', 'tconf', 't'),
('PageTsofcon', 'ofcon', 't'),
('PageTsiconf', 'iconf', 't'),
('PageTsaxctx', 'axctx', 't'),
('PageTsastcp', 'astcp', 't'),
('PageTsappsr', 'appsr', 't'),
('PageTsagspr', 'agspr', 't'),
('PageIvthint', 'thint', 'i'),
('PageIvsmslog', 'smslog', 'i'),
('PageIvloview1', 'loview1', 'i'),
('PageIvivhelpto', 'ivhelpto', 'i'),
('PageIvitimtk', 'itimtk', 'i'),
('PageIvimobc', 'imobc', 'i'),
('PageIvikywd', 'ikywd', 'i'),
('PageIvidsco', 'idsco', 'i'),
('PageIviaxpscon', 'iaxpscon', 'i'),
('PageIviaxex', 'iaxex', 'i'),
('PageIvesmsco', 'esmsco', 'i'),
('PageIvdmlscrpt', 'dmlscrpt', 'i'),
('PageIvcerrm', 'cerrm', 'i'),
('PageIvaxusracc', 'axusracc', 'i'),
('PageIvaxusers', 'axusers', 'i'),
('PageIvaxroles', 'axroles', 'i'),
('PageIvaxnxtlst', 'axnxtlst', 'i'),
('PageIvaxfinyrs', 'axfinyrs', 'i'),
('PageIvaxemllog', 'axemllog', 'i'),
('PageIvaxchtdtl', 'axchtdtl', 'i'),
('PageIvauditlog', 'auditlog', 'i'),
('PageIvapplogsm', 'applogsm', 'i'),
('PageIvadxoutlo', 'adxoutlo', 'i'),
('PageIvadxinlog', 'adxinlog', 'i'),
('Page245', 'axmme', 't'),
('PageTststfm', 'tstfm', 't'),
('PageIvtstrpt', 'tstrpt', 'i'),
('PageTstestf', 'testf', 't'),
('PageIvsamiv', 'samiv', 'i'),
('PageIvadxconfv', 'adxconfv', 'i'),
('PageTsaxglo', 'axglo', 't'),
('PageTstestf', 'testf', 't'),
('PageIvtestivie', 'testivie', 'i')
ON CONFLICT DO NOTHING;

-- Seed: axpages (10 rows)
INSERT INTO {schema}.axpages (name, caption, props, blobno, img, visible, type, parent, ordno, levelno, updatedon, createdon, importedon, createdby, updatedby, importedby, readonly, updusername, category, pagetype, intview, webenable, shortcut, icon, websubtype, workflow, oldappurl)
VALUES
('PageTstestf', 'Test form', '<root visible="T" type="p" defpage="T" name="PageTstestf" caption="Test form" createdon="03/03/2026 15:53:26" createdby="admin" importedon="" importedby="" updatedon="03/03/2026 15:53:26" updatedby="admin"><Container6 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" st="tstruct__testf"/><tstruct__testf cat="tstruct" transid="testf" parent="Container6" align="Client"/></root>
', '1', NULL, 'T', 'p', NULL, '9', '0', '03/03/2026 15:53:26', '03/03/2026 15:53:26', NULL, 'admin', 'admin', NULL, NULL, NULL, NULL, 'ttestf', NULL, NULL, NULL, '', NULL, NULL, NULL),
('PageIvaxroles', 'User Roles', '<root visible="T" type="p" defpage="T" name="PageIvaxroles" caption="User Roles" createdon="21/07/2015 12:26:56" createdby="admin" importedon="24/04/2019 12:29:53" importedby="admin" updatedon="21/07/2015 12:26:56" updatedby="admin" img="" ordno="3" levelno="2" parent="Head22" updusername="" ptype="p" pgtype="iaxroles" dbtype="oracle"><Container50 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" st="view__axroles"/><view__axroles cat="iview" name="axroles" parent="Container50" align="Client"/></root>', '1', NULL, 'T', 'p', 'Head22', '3', '2', '2025-06-26', '2025-06-26', '24/04/2019 12:29:53', 'admin', 'admin', 'admin', NULL, NULL, NULL, 'iaxroles', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('PageIvtestivie', 'Test Iview', '<root visible="T" type="p" defpage="T" name="PageIvtestivie" caption="Test Iview" createdon="03/03/2026 15:55:17" createdby="admin" importedon="" importedby="" updatedon="03/03/2026 15:55:17" updatedby="admin"><Container7 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" st="view__testivie"/><view__testivie cat="iview" name="testivie" parent="Container7" align="Client"/></root>
', '1', NULL, 'T', 'p', NULL, '10', '0', '03/03/2026 15:55:17', '03/03/2026 15:55:17', NULL, 'admin', 'admin', NULL, NULL, NULL, NULL, 'itestivie', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('PageIvauditlog', 'Audit Log', '<root visible="T" type="p" defpage="T" name="PageIvauditlog" caption="Audit Log"
 createdon="26/08/2019 10:14:38" createdby="admin" importedon="" importedby="" updatedon="26/08/2019 10:48:53" updatedby="admin" img="" ordno="33" levelno="2" 
 parent="Head18" pgtype="iauditlog" updusername=""><Container6 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" 
 st="view__auditlog"/><view__auditlog cat="iview" name="auditlog" parent="Container6" align="Client"/></root>', '1', NULL, 'T', 'p', 'Head14', '8', '2', '2025-06-26', '2025-06-26', NULL, 'admin', 'admin', NULL, NULL, NULL, NULL, 'iauditlog', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('PageIvaxusers', 'User Logins', '<root visible="T" type="p" defpage="T" name="PageIvaxusers" caption="User Logins" createdon="21/07/2015 12:32:11" createdby="admin" importedon="24/04/2019 12:29:52" importedby="admin" updatedon="21/07/2015 12:32:11" updatedby="admin" img="" ordno="4" levelno="2" parent="Head22" updusername="" ptype="p" pgtype="iaxusers" dbtype="oracle"><Container51 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" st="view__axusers"/><view__axusers cat="iview" name="axusers" parent="Container51" align="Client"/></root>', '1', NULL, 'T', 'p', 'Head22', '4', '2', '2025-06-26', '2025-06-26', '24/04/2019 12:29:52', 'admin', 'admin', 'admin', NULL, NULL, NULL, 'iaxusers', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Head14', 'Configuration', '<root img="" visible="F" name="Head14" caption="Configuration" createdon="06/11/2015 17:04:24" createdby="admin" importedon="24/04/2019 12:30:22" importedby="admin" updatedon="06/11/2015 17:04:24" updatedby="admin" type="h" ordno="2" levelno="1" parent="Head19" ptype="h" pgtype="" dbtype="oracle"></root>', '1', NULL, 'T', 'h', 'Head19', '5', '1', '2025-06-26', '2025-06-26', '24/04/2019 12:30:22', 'admin', 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('PageIvcerrm', 'Custom Error Messages', '<root visible="T" type="p" defpage="T" name="PageIvcerrm" caption="Custom Error Messages" createdon="18/11/2015 11:20:57" createdby="admin" importedon="24/04/2019 12:29:51" importedby="admin" updatedon="18/11/2015 11:20:57" updatedby="admin" img="" ordno="20" levelno="2" parent="Head17" updusername="" ptype="p" pgtype="icerrm" dbtype="oracle"><Container3 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" st="view__cerrm"/><view__cerrm cat="iview" name="cerrm" parent="Container3" align="Client"/></root>', '1', NULL, 'T', 'p', 'Head14', '7', '2', '2025-06-26', '2025-06-26', '24/04/2019 12:29:51', 'admin', 'admin', 'admin', NULL, NULL, NULL, 'icerrm', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Head22', 'User Credentials', '<root img="" visible="F" name="Head22" caption="User Credentials" createdon="07/03/2019 12:36:10" createdby="admin" importedon="24/04/2019 12:29:45" importedby="admin" updatedon="07/03/2019 12:36:10" updatedby="admin" type="h" ordno="2" levelno="1" parent="" ptype="h" pgtype="" dbtype="oracle"></root>', '1', NULL, 'T', 'h', 'Head19', '2', '1', '2025-06-26', '2025-06-26', '24/04/2019 12:29:45', 'admin', 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Head19', 'Admin Setup', '<root img="" visible="T" name="Head19" caption="Admin Setup" createdon="12/11/2015 15:56:31" createdby="admin" importedon="24/04/2019 12:29:46" importedby="admin" updatedon="12/11/2015 15:56:31" updatedby="admin" type="h" ordno="1" levelno="0" parent="" ptype="h" pgtype="" dbtype="oracle"></root>', '1', NULL, 'T', 'h', '', '1', '0', '2025-06-26', '2025-06-26', '24/04/2019 12:29:46', 'admin', 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('PageTsagspr', 'App Global Search Data/Periodically', '<root visible="T" type="p" defpage="T" name="PageTsagspr" caption="App Global Search Data/Periodically" createdon="22/10/2018 16:51:00" createdby="admin" importedon="24/04/2019 12:30:16" importedby="admin" updatedon="18/02/2019 15:20:35" updatedby="admin" img="" ordno="11" levelno="2" parent="Head17" pgtype="tagspr" updusername="" ptype="p" dbtype="oracle"><Container359 paged="False" align="Client" cat="cntr" parent="ClientPanel" defpage="T" tlhw="0,0,0,0" st="tstruct__agspr"/><tstruct__agspr cat="tstruct" transid="agspr" parent="Container359" align="Client"/></root>', '1', NULL, 'T', 'p', 'Head14', '6', '2', '2025-06-26', '2025-06-26', '24/04/2019 12:30:16', 'admin', 'admin', 'admin', NULL, NULL, NULL, 'tagspr', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axpcal (0 rows)
-- No rows in source dump for axpcal.

-- Seed: axpclouddevsettings (0 rows)
-- No rows in source dump for axpclouddevsettings.

-- Seed: axpdc (232 rows)
INSERT INTO {schema}.axpdc (tstruct, dname, caption, tablename, asgrid, allowchange, allowempty, popup, dcno, addrow, deleterow, createdby, createdon, modifiedby, modifiedon, purpose)
VALUES
('a__re', 'dc1', 'Rule engine', 'axpdef_ruleeng', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_db', 'dc1', 'dc1', 'axpdef_axvars', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_db', 'dc2', 'DB Params', 'axpdef_axvars_dbvar', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axstc', 'dc1', 'Developer Options', 'axpstructconfig', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc1', 'Task definition', 'axprocessdefv2', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc2', 'Approval details', 'axprocessdefv2', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc3', 'Display in task listing', 'axprocessdefv2', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc4', 'Form controls', 'axprocessdefv2_formctls', 'T', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc5', 'Reminders', 'axprocessdefv2_reminder', 'T', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc6', 'Escalation', 'axprocessdefv2_escalation', 'T', 'T', 'T', 'F', '6', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc7', 'Settings', 'axprocessdefv2', 'F', 'T', 'T', 'F', '7', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc1', 'Approval details', 'axprocessdefv2', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc2', 'Approval details-dmy', 'axprocessdefv2', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc3', 'Display in task listing', 'axprocessdefv2', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc4', 'Form controls', 'axprocessdefv2_formctls', 'T', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc5', 'Set value to fields', 'axprocessdefv2_setval', 'T', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc6', 'Reminders', 'axprocessdefv2_reminder', 'T', 'T', 'T', 'F', '6', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc7', 'Escalation', 'axprocessdefv2_escalation', 'T', 'T', 'T', 'F', '7', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc8', 'Settings', 'axprocessdefv2', 'F', 'T', 'T', 'F', '8', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc9', 'Approval comments', 'axprocessdefv2', 'F', 'T', 'T', 'F', '9', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc10', 'Notifications', 'axprocessdefv2', 'F', 'T', 'T', 'F', '10', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc11', 'Confirmation message', 'axprocessdefv2', 'F', 'T', 'T', 'F', '11', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc1', 'PEG Notification', 'AxNotificationDef', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc2', 'Email', 'AxNotificationDef', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc3', 'Email CC', 'AxNotificationDef', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc4', 'Email BCC', 'AxNotificationDef', 'F', 'T', 'T', 'F', '4', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc5', 'SMS', 'AxNotificationDef', 'F', 'T', 'T', 'F', '5', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc6', 'Whatsapp', 'AxNotificationDef', 'F', 'T', 'T', 'F', '6', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc7', 'Mobile notification', 'AxNotificationDef', 'F', 'T', 'T', 'F', '7', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pm', 'dc1', 'dc1', 'axpdef_peg_processmaster', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_am', 'dc1', 'Actor master', 'axpdef_peg_actor', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad__q', 'dc1', 'Outbound queue mapping', 'AxOutQueues', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('testf', 'dc1', 'Test form', 'testf1', 'F', 'T', 'T', 'F', '1', 'T', 'F', 'admin', '2026-03-03 15:53:26', 'admin', '2026-03-03 15:53:26', NULL),
('a__iq', 'dc1', 'Inbound queue', 'AxInQueues', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc1', 'Form notification', 'AxFormNotify', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc2', 'Notification recipient', 'AxFormNotify', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc3', 'Notification content', 'AxFormNotify', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc4', 'Email recipient', 'AxFormNotify', 'F', 'T', 'T', 'F', '4', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc5', 'Email body', 'AxFormNotify', 'F', 'T', 'T', 'F', '5', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc6', 'Navigation params', 'AxFormNotify', 'F', 'T', 'T', 'F', '6', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__er', 'dc1', 'Connected data', 'axentityrelations', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__pn', 'dc1', 'Periodic notification', 'AxPeriodNotify', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__pn', 'dc2', 'Condition and Navigation params', 'AxPeriodNotify', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('job_s', 'dc1', 'Axpert Job define', 'axpdef_jobs', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__ag', 'dc1', 'Dimension and value', 'AxGrouping', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__ua', 'dc1', 'User configuration', 'axusers', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__na', 'dc1', 'News and announcements', 'axpdef_news_events', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_af', 'dc1', 'dc1', 'axdef_newfield', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__ua', 'dc2', 'User roles', 'axuserlevelgroups', 'T', 'T', 'F', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_lg', 'dc1', 'Language details', 'axpdef_language', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_lg', 'dc2', 'Download resources', 'axpdef_language', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_lg', 'dc3', 'Upload resources', 'axpdef_language', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pa', 'dc1', 'Publish Axpert API', 'axpdef_publishapi', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__qm', 'dc1', 'Outbound queue', 'AxOutQueuesmst', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axipd', 'dc1', 'dc1', 'aximpdef', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__ua', 'dc3', 'User permissions', 'AxUserPermissions', 'T', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__ua', 'dc4', 'Dimensions', 'AxUserGrouping', 'F', 'T', 'T', 'F', '4', 'F', 'F', NULL, NULL, NULL, NULL, NULL),
('a__up', 'dc1', 'Permission setup', 'axpermissions', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__up', 'dc2', 'Dimensions', 'AxUserDPermissions', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a_pgm', 'dc1', 'Dimension', 'axgroupingmst', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a_pgt', 'dc1', 'Dimension mapping', 'axgrouptstructs', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('b_sql', 'dc1', 'Data source', 'Axdirectsql', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('b_sql', 'dc2', 'Custom list metadata', 'Axdirectsql_metadata', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__td', 'dc1', 'Table field Descriptor', 'axp_tabledescriptor', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axeml', 'dc1', 'dc1', 'emaildef', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_li', 'dc1', 'dc1', 'axlanguage11x', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axpub', 'dc1', 'Server details', 'dwb_publishprops', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axcdm', 'dc1', 'dc1', 'axcardtypemaster', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axapi', 'dc1', 'dc1', 'axpdef_axpertapi', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axrol', 'dc1', 'Roles Creation', 'AXUSERGROUPS', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('astcp', 'dc1', 'AxpStruct Config Props', 'axpstructconfigprops', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('astcp', 'dc2', 'Values', 'axpstructconfigproval', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_vc', 'dc1', 'dc1', 'axvarcore', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axrol', 'dc2', 'List of Responsibilities', 'AXUSERGROUPSDETAIL', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axusr', 'dc1', 'User Login', 'axusers', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('agspr', 'dc1', 'Configuration', 'axp_appsearch_data_period', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('agspr', 'dc2', 'Source', 'axp_appsearch_data_period', 'F', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('agspr', 'dc3', 'Build Params', 'axp_appsearch_data_period', 'F', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad__e', 'dc1', 'dc1', 'axpdef_axcalendar_event', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad__e', 'dc2', 'Status', 'axpdef_axcalendar_eventstatus', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2c', 'dc1', 'Process definition-Conditions', 'axprocessdefv2', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2c', 'dc2', 'Settings', 'axprocessdefv2', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axusr', 'dc2', 'Roles', 'axuserlevelgroups', 'T', 'T', 'F', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_td', 'dc1', 'Delegation', 'AxProcessDef_delegation', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_cp', 'dc1', 'Process card', 'axpdef_prcards', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__sm', 'dc1', 'Send message', 'axpeg_sendmsg', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc1', 'Axpert rule definition core', 'AxRulesDef', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc2', 'Confirmation messages', 'AxRulesDef_conmsg', 'T', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc3', 'expressions', 'AxRulesDef_expr', 'T', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc4', 'Validate expression', 'AxRulesDef_valexpr', 'T', 'T', 'T', 'F', '4', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_it', 'dc1', 'Data import templates', 'axpdef_impdata_templates', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axcal', 'dc1', 'dc1', 'AxCalendar', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axclr', 'dc1', 'dc1', 'axcalendar', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axusr', 'dc3', 'User Charts', 'axusercharts', 'T', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('temps', 'dc1', 'Custom UI', 'templates', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc1', 'Forms', 'tconfiguration', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc2', 'Customize Search', 'searchcols', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc3', 'Group Buttons', 'groupbtns', 'T', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc4', 'HTML Print', 'htmlprint', 'T', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc5', 'DropDownWithAddedButton', 'reference', 'T', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc6', 'Configuration Values', 'tconfiguration', 'F', 'T', 'T', 'F', '6', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('sendm', 'dc1', 'Email / SMS configuration', 'sendmsg', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('iconf', 'dc1', 'Report', 'iconfiguration', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('iconf', 'dc2', 'Group Buttons', 'iconfigurationdtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('iconf', 'dc3', 'Configuration Values', 'iconfiguration', 'F', 'T', 'T', 'F', '3', 'F', 'T', NULL, NULL, NULL, NULL, NULL),
('dsigc', 'dc1', 'DSign Configuration', 'dsignconfig', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('dsigc', 'dc2', 'dc2', 'dsignconfigdtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('dsgcn', 'dc1', 'dc1', 'AXDSIGNCONFIG', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('dgmal', 'dc1', 'DSign Mail Configuration', 'AXDSIGNMAIL', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('custo', 'dc1', 'Custom Types', 'customtypes', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axglo', 'dc1', 'Global Settings', 'AxGloVar', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axfin', 'dc1', 'Year', 'financialyear', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axfin', 'dc2', 'Periods', 'financialyeardtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, '-- fill grid query,removed on 17/11/15
select ''00'' periodcode, to_char( :startdate ,''YYYY - '')||''00'' perioddesc, ''Q0'' quarter, ( 
:startdate - 1) pstartdate, ( :startdate - 1)  penddate  
from dual
union all
select lpad(level,2,''0'') periodcode, 
to_char(add_months( :startdate, level-1),''YYYY - MM'') perioddesc, 
case when level<=3 then ''Q1'' 
when level between 4 and 6 then ''Q2'' 
when level between 7 and 9 then ''Q3'' else ''Q4'' end quarter, 
add_months( :startdate, level-1) pstartdate, 
add_months( :startdate, level)-1 penddate
FROM Dual CONNECT BY Level <= MONTHS_BETWEEN( :enddate , :startdate ) + 1
union all
select ''99'' periodcode, to_char( :startdate ,''YYYY - '')||''99'' perioddesc, ''Q9'' quarter,  
:enddate pstartdate, :enddate penddate 
from dual
order by periodcode

'),
('axerr', 'dc1', 'Custom Error Messages', 'AXCONSTRAINTS', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('appsr', 'dc1', 'dc1', 'axp_appsearch_data', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('appsr', 'dc2', 'Params -  ({rowcount})', 'axp_appsearchdtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('appsr', 'dc3', 'Param String', 'axp_appsearch_data', 'F', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_db', 'dc1', 'dc1', 'axpdef_axvars', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_db', 'dc2', 'DB Params', 'axpdef_axvars_dbvar', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axstc', 'dc1', 'Developer Options', 'axpstructconfig', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc1', 'Task definition', 'axprocessdefv2', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc2', 'Approval details', 'axprocessdefv2', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc3', 'Display in task listing', 'axprocessdefv2', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc4', 'Form controls', 'axprocessdefv2_formctls', 'T', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc5', 'Reminders', 'axprocessdefv2_reminder', 'T', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc6', 'Escalation', 'axprocessdefv2_escalation', 'T', 'T', 'T', 'F', '6', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2m', 'dc7', 'Settings', 'axprocessdefv2', 'F', 'T', 'T', 'F', '7', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc1', 'Approval details', 'axprocessdefv2', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc2', 'Approval details-dmy', 'axprocessdefv2', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc3', 'Display in task listing', 'axprocessdefv2', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc4', 'Form controls', 'axprocessdefv2_formctls', 'T', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc5', 'Set value to fields', 'axprocessdefv2_setval', 'T', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc6', 'Reminders', 'axprocessdefv2_reminder', 'T', 'T', 'T', 'F', '6', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc7', 'Escalation', 'axprocessdefv2_escalation', 'T', 'T', 'T', 'F', '7', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc8', 'Settings', 'axprocessdefv2', 'F', 'T', 'T', 'F', '8', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc9', 'Approval comments', 'axprocessdefv2', 'F', 'T', 'T', 'F', '9', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc10', 'Notifications', 'axprocessdefv2', 'F', 'T', 'T', 'F', '10', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('pgv2a', 'dc11', 'Confirmation message', 'axprocessdefv2', 'F', 'T', 'T', 'F', '11', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc1', 'PEG Notification', 'AxNotificationDef', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc2', 'Email', 'AxNotificationDef', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc3', 'Email CC', 'AxNotificationDef', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc4', 'Email BCC', 'AxNotificationDef', 'F', 'T', 'T', 'F', '4', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc5', 'SMS', 'AxNotificationDef', 'F', 'T', 'T', 'F', '5', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc6', 'Whatsapp', 'AxNotificationDef', 'F', 'T', 'T', 'F', '6', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pn', 'dc7', 'Mobile notification', 'AxNotificationDef', 'F', 'T', 'T', 'F', '7', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pm', 'dc1', 'dc1', 'axpdef_peg_processmaster', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_am', 'dc1', 'Actor master', 'axpdef_peg_actor', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad__q', 'dc1', 'Outbound queue mapping', 'AxOutQueues', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__iq', 'dc1', 'Inbound queue', 'AxInQueues', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc1', 'Form notification', 'AxFormNotify', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc2', 'Notification recipient', 'AxFormNotify', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc3', 'Notification content', 'AxFormNotify', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc4', 'Email recipient', 'AxFormNotify', 'F', 'T', 'T', 'F', '4', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc5', 'Email body', 'AxFormNotify', 'F', 'T', 'T', 'F', '5', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__fn', 'dc6', 'Navigation params', 'AxFormNotify', 'F', 'T', 'T', 'F', '6', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__er', 'dc1', 'Connected data', 'axentityrelations', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__na', 'dc1', 'News and announcements', 'axpdef_news_events', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_af', 'dc1', 'dc1', 'axdef_newfield', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_lg', 'dc1', 'Language details', 'axpdef_language', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_lg', 'dc2', 'Download resources', 'axpdef_language', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_lg', 'dc3', 'Upload resources', 'axpdef_language', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pa', 'dc1', 'Publish Axpert API', 'axpdef_publishapi', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__qm', 'dc1', 'Outbound queue', 'AxOutQueuesmst', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axipd', 'dc1', 'dc1', 'aximpdef', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__td', 'dc1', 'Table field Descriptor', 'axp_tabledescriptor', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axeml', 'dc1', 'dc1', 'emaildef', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_li', 'dc1', 'dc1', 'axlanguage11x', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axpub', 'dc1', 'Server details', 'dwb_publishprops', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axcdm', 'dc1', 'dc1', 'axcardtypemaster', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axapi', 'dc1', 'dc1', 'axpdef_axpertapi', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('astcp', 'dc1', 'AxpStruct Config Props', 'axpstructconfigprops', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('astcp', 'dc2', 'Values', 'axpstructconfigproval', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_vc', 'dc1', 'dc1', 'axvarcore', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('agspr', 'dc1', 'Configuration', 'axp_appsearch_data_period', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('agspr', 'dc2', 'Source', 'axp_appsearch_data_period', 'F', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('agspr', 'dc3', 'Build Params', 'axp_appsearch_data_period', 'F', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad__e', 'dc1', 'dc1', 'axpdef_axcalendar_event', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad__e', 'dc2', 'Status', 'axpdef_axcalendar_eventstatus', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2c', 'dc1', 'Process definition-Conditions', 'axprocessdefv2', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('pgv2c', 'dc2', 'Settings', 'axprocessdefv2', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_td', 'dc1', 'Delegation', 'AxProcessDef_delegation', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_cp', 'dc1', 'Process card', 'axpdef_prcards', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('a__sm', 'dc1', 'Send message', 'axpeg_sendmsg', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc1', 'Axpert rule definition core', 'AxRulesDef', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc2', 'Confirmation messages', 'AxRulesDef_conmsg', 'T', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc3', 'expressions', 'AxRulesDef_expr', 'T', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ruldf', 'dc4', 'Validate expression', 'AxRulesDef_valexpr', 'T', 'T', 'T', 'F', '4', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_it', 'dc1', 'Data import templates', 'axpdef_impdata_templates', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axcal', 'dc1', 'dc1', 'AxCalendar', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axclr', 'dc1', 'dc1', 'axcalendar', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('temps', 'dc1', 'Custom UI', 'templates', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc1', 'Forms', 'tconfiguration', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc2', 'Customize Search', 'searchcols', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc3', 'Group Buttons', 'groupbtns', 'T', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc4', 'HTML Print', 'htmlprint', 'T', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc5', 'DropDownWithAddedButton', 'reference', 'T', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('tconf', 'dc6', 'Configuration Values', 'tconfiguration', 'F', 'T', 'T', 'F', '6', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('sendm', 'dc1', 'Email / SMS configuration', 'sendmsg', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('iconf', 'dc1', 'Report', 'iconfiguration', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('iconf', 'dc2', 'Group Buttons', 'iconfigurationdtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('iconf', 'dc3', 'Configuration Values', 'iconfiguration', 'F', 'T', 'T', 'F', '3', 'F', 'T', NULL, NULL, NULL, NULL, NULL),
('dsigc', 'dc1', 'DSign Configuration', 'dsignconfig', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('dsigc', 'dc2', 'dc2', 'dsignconfigdtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('dsgcn', 'dc1', 'dc1', 'AXDSIGNCONFIG', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('dgmal', 'dc1', 'DSign Mail Configuration', 'AXDSIGNMAIL', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('custo', 'dc1', 'Custom Types', 'customtypes', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axglo', 'dc1', 'Global Settings', 'AxGloVar', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axfin', 'dc1', 'Year', 'financialyear', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('axfin', 'dc2', 'Periods', 'financialyeardtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, '-- fill grid query,removed on 17/11/15
select ''00'' periodcode, to_char( :startdate ,''YYYY - '')||''00'' perioddesc, ''Q0'' quarter, ( 
:startdate - 1) pstartdate, ( :startdate - 1)  penddate  
from dual
union all
select lpad(level,2,''0'') periodcode, 
to_char(add_months( :startdate, level-1),''YYYY - MM'') perioddesc, 
case when level<=3 then ''Q1'' 
when level between 4 and 6 then ''Q2'' 
when level between 7 and 9 then ''Q3'' else ''Q4'' end quarter, 
add_months( :startdate, level-1) pstartdate, 
add_months( :startdate, level)-1 penddate
FROM Dual CONNECT BY Level <= MONTHS_BETWEEN( :enddate , :startdate ) + 1
union all
select ''99'' periodcode, to_char( :startdate ,''YYYY - '')||''99'' perioddesc, ''Q9'' quarter,  
:enddate pstartdate, :enddate penddate 
from dual
order by periodcode

'),
('axerr', 'dc1', 'Custom Error Messages', 'AXCONSTRAINTS', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('appsr', 'dc1', 'dc1', 'axp_appsearch_data', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('appsr', 'dc2', 'Params -  ({rowcount})', 'axp_appsearchdtl', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('appsr', 'dc3', 'Param String', 'axp_appsearch_data', 'F', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__ap', 'dc1', 'Auto print', 'AxAutoPrints', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('axvar', 'dc1', 'dc1', 'axp_vp', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__cd', 'dc1', 'New Card', 'axp_cards', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pr', 'dc1', 'Mail Settings', 'axpdef_axpertprops', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pr', 'dc2', 'Application Settings', 'axpdef_axpertprops', 'F', 'T', 'T', 'F', '2', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pr', 'dc3', 'Password Policy Settings', 'axpdef_axpertprops', 'F', 'T', 'T', 'F', '3', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_pr', 'dc4', 'OTP settings', 'axpdef_axpertprops', 'F', 'T', 'T', 'F', '4', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_pr', 'dc5', 'SSO settings', 'axpdef_axpertprops', 'F', 'T', 'T', 'F', '5', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_pr', 'dc6', 'Mobile App Settings', 'axpdef_axpertprops', 'F', 'T', 'T', 'F', '6', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('tstfm', 'dc1', 'Test Form', 'tstfm1', 'F', 'T', 'T', 'F', '1', 'T', 'F', 'admin', '2025-11-12 11:40:29', 'admin', '2025-11-12 11:40:29', NULL),
('axurg', 'dc1', 'User Activation', 'axuseractivations', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('apidg', 'dc1', 'Confiuration', 'executeapidef', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('apidg', 'dc2', 'Data source', 'executeapidef', 'F', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ctype', 'dc1', 'Custom Data Type', 'axp_customdatatype', 'F', 'T', 'T', 'F', '1', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('a__ug', 'dc1', 'User Groups', 'axpdef_usergroups', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_at', 'dc1', 'Actor', 'axpdef_peg_actor', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL),
('ad_at', 'dc2', 'User groups', 'axpdef_peg_actorusergrp', 'T', 'T', 'T', 'F', '2', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_at', 'dc3', 'Data group conditions', 'axpdef_peg_grpfilter', 'T', 'T', 'T', 'F', '3', 'T', 'T', NULL, NULL, NULL, NULL, NULL),
('ad_ur', 'dc1', 'User role', 'axpdef_userroles', 'F', 'T', 'T', 'F', '1', 'T', 'F', NULL, NULL, NULL, NULL, NULL)
ON CONFLICT DO NOTHING;

-- Seed: axpdef_axcalendar_event (4 rows)
INSERT INTO {schema}.axpdef_axcalendar_event (axpdef_axcalendar_eventid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, eventname, eventcolor)
VALUES
('1116010000000', 'F', '0', NULL, 'admin', '2022-12-14 20:01:28', 'admin', '2022-12-14 19:45:44', NULL, '1', '1', NULL, NULL, NULL, 'Meeting', 'cerise'),
('1117110000000', 'F', '0', NULL, 'admin', '2022-12-15 17:20:08', 'admin', '2022-12-15 17:20:08', NULL, '1', '1', NULL, NULL, NULL, 'Personal', 'blue'),
('1117110000002', 'F', '0', NULL, 'admin', '2022-12-15 17:20:25', 'admin', '2022-12-15 17:20:25', NULL, '1', '1', NULL, NULL, NULL, 'Leave', 'Red'),
('1117110000001', 'F', '0', NULL, 'admin', '2022-12-16 12:27:11', 'admin', '2022-12-15 17:20:19', NULL, '1', '1', NULL, NULL, NULL, 'Online meet', 'Fuchsia Blue')
ON CONFLICT DO NOTHING;

-- Seed: axpdef_axcalendar_eventstatus (0 rows)
-- No rows in source dump for axpdef_axcalendar_eventstatus.

-- Seed: axpdef_axpanalytics_mdata (0 rows)
-- No rows in source dump for axpdef_axpanalytics_mdata.

-- Seed: axpdef_axpertapi (0 rows)
-- No rows in source dump for axpdef_axpertapi.

-- Seed: axpdef_axpertprops (1 rows)
INSERT INTO {schema}.axpdef_axpertprops (axpdef_axpertpropsid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, smtphost, smtpport, smtpuser, smtppwd, axpsiteno, amtinmillions, currseperator, lastlogin, autogen, customfrom, customto, loginattempt, pwdexp, pwdchange, pwdminchar, pwdmaxchar, pwdreuse, pwdencrypt, pwdalphanum, pwdcapchar, pwdsmallchar, pwdnumchar, pwdsplchar, emailsubject, emailbody, smscontent, onlysso, sso_windows, sso_saml, sso_office365, sso_okta, sso_google, sso_facebook, sso_openid, tbl_windows, tbl_saml, tbl_okta, tbl_office365, tbl_google, tbl_facebook, tbl_openid, otpauth, otpchars, otpexpiry, mob_citizenuser, mob_geofencing, mob_geotag, mob_fingerauth, mob_faceauth, mob_forcelogin, mob_forceloginusers)
VALUES
('1', 'F', '0', NULL, 'admin', '2026-02-28 10:20:31', 'admin', '2022-01-17 13:28:03', NULL, '1', '1', NULL, NULL, NULL, NULL, '0', NULL, NULL, '0', 'F', 'F', 'T', 'F', NULL, NULL, '0', '0', '0', '3', '20', '0', 'F', 'F', '0', '0', '0', '0', 'Axpert OTP Auth!!!', 'Dear {username},

Your One-Time Password (OTP) for accessing your Account is: {otp}

This OTP is valid for the next {otpexpirytime} minutes. Please do not share this code with anyone. If you did not request this code, please contact our support team immediately..

Thank you,
Axpert Support', 'Dear {username},

Your One-Time Password (OTP) for accessing your account is: {otp}

This OTP is valid for the next {otpexpirytime} minutes. Please do not share this code with anyone. .
If you did not request this code, please contact our support team immediately.

Thank you,
Axpert Support.', NULL, NULL, 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'F', '4', '3 mins', 'F', 'F', 'F', 'F', 'F', 'F', 'F')
ON CONFLICT DO NOTHING;

-- Seed: axpdef_axvars (0 rows)
-- No rows in source dump for axpdef_axvars.

-- Seed: axpdef_axvars_dbvar (0 rows)
-- No rows in source dump for axpdef_axvars_dbvar.

-- Seed: axpdef_impdata_templates (0 rows)
-- No rows in source dump for axpdef_impdata_templates.

-- Seed: axpdef_jobs (0 rows)
-- No rows in source dump for axpdef_jobs.

-- Seed: axpdef_language (0 rows)
-- No rows in source dump for axpdef_language.

-- Seed: axpdef_news_events (0 rows)
-- No rows in source dump for axpdef_news_events.

-- Seed: axpdef_peg_actor (0 rows)
-- No rows in source dump for axpdef_peg_actor.

-- Seed: axpdef_peg_actorusergrp (0 rows)
-- No rows in source dump for axpdef_peg_actorusergrp.

-- Seed: axpdef_peg_grpfilter (0 rows)
-- No rows in source dump for axpdef_peg_grpfilter.

-- Seed: axpdef_peg_processmaster (0 rows)
-- No rows in source dump for axpdef_peg_processmaster.

-- Seed: axpdef_peg_usergroups (0 rows)
-- No rows in source dump for axpdef_peg_usergroups.

-- Seed: axpdef_prcards (0 rows)
-- No rows in source dump for axpdef_prcards.

-- Seed: axpdef_publishapi (0 rows)
-- No rows in source dump for axpdef_publishapi.

-- Seed: axpdef_ruleeng (0 rows)
-- No rows in source dump for axpdef_ruleeng.

-- Seed: axpdef_ruleeng_expr (0 rows)
-- No rows in source dump for axpdef_ruleeng_expr.

-- Seed: axpdef_ruleeng_fctl (0 rows)
-- No rows in source dump for axpdef_ruleeng_fctl.

-- Seed: axpdef_ruleeng_masks (0 rows)
-- No rows in source dump for axpdef_ruleeng_masks.

-- Seed: axpdef_ruleeng_msg (0 rows)
-- No rows in source dump for axpdef_ruleeng_msg.

-- Seed: axpdef_ruleeng_valexpr (0 rows)
-- No rows in source dump for axpdef_ruleeng_valexpr.

-- Seed: axpdef_script (0 rows)
-- No rows in source dump for axpdef_script.

-- Seed: axpdef_usergroups (1 rows)
INSERT INTO {schema}.axpdef_usergroups (axpdef_usergroupsid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, usernames, users_group_name, users_group_description, isactive)
VALUES
('1002770000000', 'F', '0', NULL, 'admin', '2025-11-12 10:30:40', 'admin', '2025-11-12 10:30:40', NULL, '1', '1', NULL, NULL, NULL, NULL, 'QA', 'QA', 'T')
ON CONFLICT DO NOTHING;

-- Seed: axpdef_userroles (0 rows)
-- No rows in source dump for axpdef_userroles.

-- Seed: axpdflanguage (0 rows)
-- No rows in source dump for axpdflanguage.

-- Seed: axpdraft (0 rows)
-- No rows in source dump for axpdraft.

-- Seed: axpeg_sendmsg (0 rows)
-- No rows in source dump for axpeg_sendmsg.

-- Seed: axperiodnotify (0 rows)
-- No rows in source dump for axperiodnotify.

-- Seed: axpermissions (0 rows)
-- No rows in source dump for axpermissions.

-- Seed: axpertlog (1 rows)
INSERT INTO {schema}.axpertlog (sessionid, username, calledon, structname, recordid, timetaken, db_conntime, dbtimetaken, servicename, serviceresult, callfinished, calldetails)
VALUES
(NULL, NULL, '2026-04-13 17:54:41', NULL, '0', '401', '0', '28', 'GetDBConnection', 'success', '2026-04-13 17:54:42', NULL)
ON CONFLICT DO NOTHING;

-- Seed: axpertreports (0 rows)
-- No rows in source dump for axpertreports.

-- Seed: axpexception (0 rows)
-- No rows in source dump for axpexception.

-- Seed: axpexchange (0 rows)
-- No rows in source dump for axpexchange.

-- Seed: axpfgdtl (9 rows)
INSERT INTO {schema}.axpfgdtl (tstruct, fgname, srcfld, tarfld, caption)
VALUES
('b_sql', 'fillgrid1', 'fldname', 'fldname', 'Field name'),
('b_sql', 'fillgrid1', 'fldcaption', 'fldcaption', 'Caption'),
('b_sql', 'fillgrid1', 'datatypeui', 'datatypeui', 'Datatype'),
('b_sql', 'fillgrid1', 'filter', 'filter', 'Filter'),
('b_sql', 'fillgrid1', 'sourcetable', 'sourcetable', 'Source table'),
('b_sql', 'fillgrid1', 'sourcefld', 'sourcefld', 'Source field'),
('b_sql', 'fillgrid1', 'hyp_structtype', 'hyp_structtype', 'Hyperlink type'),
('b_sql', 'fillgrid1', 'hyp_struct', 'hyp_struct', 'Hyperlink target'),
('b_sql', 'fillgrid1', 'tbl_hyperlink', 'tbl_hyperlink', 'Hyperlink mappings')
ON CONFLICT DO NOTHING;

-- Seed: axpfillgrid (1 rows)
INSERT INTO {schema}.axpfillgrid (tstruct, fgname, caption, fgsql, fromiview, tardc, multiselect, autoshow, srcdc, validat, exeonsave, firmbind, selecton, footer, valexpr, addrows, purpose, gfld, createdby, createdon, modifiedby, modifiedon, plist)
VALUES
('b_sql', 'fillgrid1', 'Fill ADS query columns', NULL, 'F', '2', 'F', 'T', '0', 'F', 'F', 'F', 'OnClick', NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL, 'recid,sqlquerycols')
ON CONFLICT DO NOTHING;
